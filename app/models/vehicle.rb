class Vehicle < ApplicationRecord
  belongs_to :vehicle_type
  has_one :engine
  has_many :doors
  has_many :advertisements

  before_validation :set_vehicle_type

  def set_vehicle_type
    self.vehicle_type =
      VehicleType.find_or_create_by(name: self.class::VEHICLE_TYPE)
  end
end
