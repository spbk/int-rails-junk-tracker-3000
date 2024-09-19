class Vehicle < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :vehicle_type
  has_one :engine
  has_many :doors
  has_many :advertisements

  before_validation :set_vehicle_type
  before_create :register_vehicle

  def register_vehicle
    self.registration_id = VehicleRegistrationService.register_vehicle(self)
  end

  def set_vehicle_type
    self.vehicle_type =
      VehicleType.find_or_create_by(name: self.class::VEHICLE_TYPE)
  end

  def type
    self.class.VEHICLE_TYPE
  end

  def mileage_verbiage
    if mileage < 20000
      "Low (#{number_with_delimiter(mileage)})"
    elsif mileage.in?(20000...100000)
      "Medium (#{number_with_delimiter(mileage)})"
    else
      "High (#{number_with_delimiter(mileage)})"
    end
  end

  def engine_status
    engine.status.capitalize
  end
end
