class Coupe < Vehicle
  VEHICLE_TYPE = "coupe"

  default_scope { joins(:vehicle_type).where(vehicle_type: { name: VEHICLE_TYPE })}

  def create_ad_text
    <<~ADD
      #{nickname}
      Registration number: #{registration_id}
      Mileage: #{mileage_verbiage}
      Engine: #{engine_status}
    ADD
  end
end