class Sedan < Vehicle
  validate :door_count

  def create_ad_text
    <<~ADD
      #{nickname}
      Registration number: #{registration_id}
      Mileage: #{mileage_verbiage}
      Engine: #{engine_status}
    ADD
  end

  def door_count
    return if doors.count.in?(0..4)

    errors.add(:doors, "must have between 0 and 4 doors")
  end
end