class MiniVan < Vehicle
  VEHICLE_TYPE = "mini-van"

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}

  def create_ad_text
    <<~ADD
      Looking for a Mini-Van? Look no further!

      ~~~ #{nickname} ~~~

      Registration number: #{registration_id}
      Mileage: #{mileage_verbiage}
      Engine: #{engine_status}
      Regular Doors: #{regular_door_count}
      Sliding Doors: #{sliding_door_count}
    ADD
  end

  def regular_door_count
    doors.where(sliding: false).count
  end

  def sliding_door_count
    doors.where(sliding: true).count
  end
end