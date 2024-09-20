class Motorcycle < Vehicle
  VEHICLE_TYPE = "motorcycle"

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}

  def create_ad_text
    <<~ADD
      ~~~ Motorcycle for Sale ~~~

      #{nickname}

      Registration number:
      #{registration_id}

      Mileage:
      #{mileage_verbiage}

      Engine:
      #{engine_status}

      Seat:
      #{seat_status}
    ADD
  end

  def seat_status
    seat.status.capitalize
  end
end