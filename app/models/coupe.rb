class Coupe < Vehicle
  VEHICLE_TYPE = "coupe"

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}
end