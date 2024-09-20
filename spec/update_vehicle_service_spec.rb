require "rails_helper"

RSpec.describe UpdateVehicleService do
  let(:registration_id) { "reg-id" }

  before do
    allow(VehicleRegistrationService)
      .to receive(:register_vehicle)
      .and_return(registration_id)
  end

  describe ".update_from_request_params" do
    it "updates a motorcycle" do
      params = {
        "nickname"=>"Duc",
        "mileage"=>"122",
        "engine_status"=>"works",
        "seat_status"=>"works",
        "vehicle_type"=>"motorcycle"
      }

      vehicle = CreateVehicleService.create_from_request_params(params)[:vehicle]

      update_params = {
        "nickname"=>"Monster",
        "seat_status"=>"junk",
        "mileage"=>"444"
      }

      updated_vehicle =
        described_class.update_from_request_params(vehicle, update_params)[:vehicle]

      expect(updated_vehicle.nickname).to eq("Monster")
      expect(updated_vehicle.seat.status).to eq("junk")
      expect(updated_vehicle.mileage).to eq(444)
    end
  end

  it "updates a coupe" do
    params = {
      "nickname"=>"911",
      "mileage"=>"0",
      "num_regular_doors"=>"2",
      "engine_status"=>"fixable",
      "vehicle_type"=>"coupe"
    }

    vehicle = CreateVehicleService.create_from_request_params(params)[:vehicle]

    update_params = {
      "nickname"=>"911 Turbo",
      "mileage"=>"10000",
      "engine_status"=>"junk"
    }

    updated_vehicle =
      described_class.update_from_request_params(vehicle, update_params)[:vehicle]

    expect(updated_vehicle.nickname).to eq("911 Turbo")
    expect(updated_vehicle.mileage).to eq(10000)
    expect(updated_vehicle.engine.status).to eq("junk")
  end

  it "updates a mini-van" do
    params = {
      "nickname"=>"Sprinter",
      "mileage"=>"122",
      "num_regular_doors"=>"2",
      "num_sliding_doors"=>"2",
      "engine_status"=>"works",
      "vehicle_type"=>"minivan"
    }

    vehicle = CreateVehicleService.create_from_request_params(params)[:vehicle]

    update_params = {
      "num_sliding_doors"=>"4"
    }

    updated_vehicle =
      described_class.update_from_request_params(vehicle, update_params)[:vehicle]


    expect(updated_vehicle.sliding_door_count).to eq(4)
  end

  it "updates the ad when a vehicle is updated" do
    params = {
      "nickname"=>"Duc",
      "mileage"=>"122",
      "engine_status"=>"works",
      "seat_status"=>"works",
      "vehicle_type"=>"motorcycle"
    }

    vehicle = CreateVehicleService.create_from_request_params(params)[:vehicle]

    expect(vehicle.advertisements.last.display).to match(/Duc/)

    update_params = {
      "nickname"=>"Monster",
      "seat_status"=>"junk",
      "mileage"=>"444"
    }

    described_class.update_from_request_params(vehicle, update_params)

    expect(vehicle.advertisements.last.display).to match(/Monster/)
  end
end