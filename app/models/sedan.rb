class Sedan < Vehicle
  VEHICLE_TYPE = "sedan"

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}
end