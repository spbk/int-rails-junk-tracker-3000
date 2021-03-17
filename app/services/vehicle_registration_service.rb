class VehicleRegistrationService
  # Given a vehicle model, returns a new registion ID
  def self.register_vehicle(vehicle)
    raise "Vehicle model is required to complete registration!" unless vehicle.is_a?(Vehicle)

    # Pretend we're hitting an external service :)
    sleep(3)

    charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
    Array.new(30) { charset.sample }.join
  end
end
