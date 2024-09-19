class Motorcycle < Vehicle
  VEHICLE_TYPE = "motorcycle"

  has_one :seat

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}
end