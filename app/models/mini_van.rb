class MiniVan < Vehicle
  VEHICLE_TYPE = "mini-van"

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}
end