class CreateVehicleService
  def self.create_from_request_params(params)
    #   Parameters: {"nickname"=>"arst", "mileage"=>"234324", "num_regular_doors"=>"0", "num_sliding_doors"=>"0", "engine_status"=>"works", "seat_status"=>"works", "type"=>"coupe"}

    vehicle = Vehicle.new(
      nickname: params["nickname"],
      mileage: params["mileage"].to_i,
      type: params["vehicle_type"].capitalize)

    vehicle.engine = Engine.new(status: params["engine_status"])

    if vehicle.is_a?(Sedan) || vehicle.is_a?(Coupe) || vehicle.is_a?(Minivan)
      params["num_regular_doors"].to_i.times do
        vehicle.doors << Door.new
      end
    end

    if vehicle.is_a?(Minivan)
      params["num_sliding_doors"].to_i.times do
        vehicle.doors << Door.new(sliding: true)
      end
    end

    if vehicle.is_a?(Motorcycle)
      vehicle.seat = Seat.new(status: params["seat_status"])
    end

    if vehicle.save
      create_promotion(vehicle)

      {status: :ok, vehicle: vehicle}
    else
      {status: :error, messages: vehicle.errors.messages}
    end

  end

  def self.create_promotion(vehicle)
    VehiclePromotionService.create_ad(vehicle)
  end
end