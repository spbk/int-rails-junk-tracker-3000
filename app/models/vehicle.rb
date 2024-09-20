class Vehicle < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  has_one :engine, dependent: :destroy
  has_many :doors, dependent: :destroy
  has_many :advertisements, dependent: :destroy
  has_one :seat, dependent: :destroy

  after_create :register_vehicle

  validates :nickname, presence: true
  validates :mileage, presence: true

  def register_vehicle
    self.registration_id = VehicleRegistrationService.register_vehicle(self)
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

  def as_json(_)
    super(include: [:engine, :doors, :seat, :advertisements]).merge(type: type)
  end
end
