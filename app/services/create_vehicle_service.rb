class CreateVehicleService
  def self.create_from_request_params(params)
    #   Parameters: {"nickname"=>"arst", "mileage"=>"234324", "numDoors"=>"0", "numSlidingDoors"=>"0", "engineStatus"=>"works", "seatStatus"=>"works", "vehicleType"=>"coupe"}

    vehicle = vehicle_type(params["vehicleType"])
                .new(nickname: params["nickname"],
                     mileage: params["mileage"].to_i)

    vehicle.engine = Engine.new(status: params["engineStatus"])

    if vehicle.is_a?(Sedan) || vehicle.is_a?(Coupe) || vehicle.is_a?(MiniVan)
      params["numDoors"].to_i.times do
        vehicle.doors << Door.new
      end
    end

    if vehicle.is_a?(MiniVan)
      params["numSlidingDoors"].to_i.times do
        vehicle.doors << Door.new(sliding: true)
      end
    end

    if vehicle.is_a?(Motorcycle)
      vehicle.seat = Seat.new(status: params["seatStatus"])
    end

    if vehicle.save!
      create_promotion(vehicle)

      {status: :ok, vehicle: vehicle}
    else
      {status: :error, messages: vehicle.errors.messages}
    end

  end

  def self.vehicle_type(type)
    if type.match?(/coupe/i)
      Coupe
    elsif type.match(/motorcycle/i)
      Motorcycle
    elsif type.match(/sedan/i)
      Sedan
    else
      MiniVan
    end
  end

  def self.create_promotion(vehicle)
    VehiclePromotionService.create_ad(vehicle)
  end
end