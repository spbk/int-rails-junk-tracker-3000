require "rails_helper"

RSpec.describe CreateVehicleService do
  let(:registration_id) { "reg-id" }

  before do
    allow(VehicleRegistrationService)
      .to receive(:register_vehicle)
      .and_return(registration_id)
  end

  describe ".create_from_request_params" do
    it "creates a vehicle of the given type" do
      params = {
        "nickname"=>"Duc",
        "mileage"=>"122",
        "numDoors"=>"0",
        "numSlidingDoors"=>"0",
        "engineStatus"=>"works",
        "seatStatus"=>"works",
        "vehicleType"=>"motorcycle"
      }

      res = described_class.create_from_request_params(params)

      motorcycle = res[:vehicle]

      expect(motorcycle).to be_a(Motorcycle)
      expect(motorcycle.seat_status).to eq("Works")
      expect(motorcycle.doors.count).to eq(0)
    end
  end

  it "creates an ad for the vehicle" do
    params = {
      "nickname"=>"Duc",
      "mileage"=>"122",
      "numDoors"=>"0",
      "numSlidingDoors"=>"0",
      "engineStatus"=>"works",
      "seatStatus"=>"works",
      "vehicleType"=>"motorcycle"
    }

    vehicle = described_class.create_from_request_params(params)[:vehicle]

    ad = vehicle.advertisements.last

    expect(ad.display).to eq(<<~AD)
      ~~~ Motorcycle for Sale ~~~

      Duc

      Registration number:
      reg-id

      Mileage:
      Low (122)

      Engine:
      Works

      Seat:
      Works
    AD
  end
end