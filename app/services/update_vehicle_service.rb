class UpdateVehicleService
  class << self
    def update_from_request_params(vehicle, params)
      vehicle.assign_attributes(params.slice("nickname", "mileage"))
      vehicle.engine.status = params["engine_status"] if params["engine_status"]

      case vehicle.type
      when "Motorcycle"
        update_motorcycle(vehicle, params)
      when "Minivan"
        update_minivan(vehicle, params)
      when "Sedan", "Coupe"
        update_sedan_coupe(vehicle, params)
      end

      save_and_respond(vehicle)
    end

    def update_motorcycle(vehicle, params)
      vehicle.seat.status = params["seat_status"] if params["seat_status"]
    end

    def update_minivan(vehicle, params)
      num_regular_doors = params.fetch("num_regular_doors", nil)
      num_sliding_doors = params.fetch("num_sliding_doors", nil)

      # Don't try and diff doors, just recreate them
      # if the params are provided

      if num_sliding_doors || num_regular_doors
        vehicle.doors.destroy_all

        num_regular_doors.to_i.times do
          vehicle.doors << Door.new(vehicle: vehicle)
        end

        num_sliding_doors.to_i.times do
          vehicle.doors << Door.new(vehicle: vehicle, sliding: true)
        end
      end
    end

    def update_sedan_coupe(vehicle, params)
      num_regular_doors = params.fetch("num_regular_doors", nil)

      # Don't try and diff doors, just recreate them
      # if the params are provided

      if num_regular_doors
        vehicle.doors.destroy_all

        num_regular_doors.to_i.times do
          vehicle.doors << Door.new(vehicle: vehicle)
        end
      end
    end

    def save_and_respond(vehicle)
      if vehicle.save
        VehiclePromotionService.update_ad(
          vehicle.advertisements.last.id,
          vehicle
        )

        {status: :ok, vehicle: vehicle}
      else
        {status: :error, messages: vehicle.errors.messages}
      end
    end
  end
end