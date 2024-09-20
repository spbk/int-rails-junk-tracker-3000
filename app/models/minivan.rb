class Minivan < Vehicle
  validate :door_count

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

  private

  def door_count
    return if doors.count.in?(0..4)

    errors.add(:doors, "must have between 0 and 4 doors")
  end
end