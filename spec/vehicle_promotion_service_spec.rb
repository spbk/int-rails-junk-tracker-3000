require "rails_helper"

RSpec.describe VehiclePromotionService do
  let(:registration_id) { "415Hn3JTu7obqNj151gmuscoq0kWCy" }

  let(:vehicle) do
    Sedan.create!(nickname: "2020 Honda Civic", mileage: 5134).tap do |vehicle|
      Engine.create!(vehicle: vehicle)
    end
  end

  before do
    allow(VehicleRegistrationService)
      .to receive(:register_vehicle)
      .and_return(registration_id)
  end

  describe ".create_ad" do
    it "creates an advertisement for the vehicle" do
      expect { described_class.create_ad(vehicle) }
        .to change { vehicle.advertisements.count }.from(0).to(1)
    end

    it "creates an correctly formatted advertisement" do
      advertisement = Advertisement.find(described_class.create_ad(vehicle))

      expect(advertisement.display).to eq(<<~AD)
        2020 Honda Civic
        Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
        Mileage: Low (5,134)
        Engine: Works
      AD
    end
  end

  describe ".update_ad" do
    it "updates the advertisement given its id" do
      ad_id = described_class.create_ad(vehicle)

      vehicle.update!(nickname: "Honda", mileage: 120000)

      described_class.update_ad(ad_id, vehicle)

      advertisement = Advertisement.find(ad_id)

      expect(advertisement.display).to eq(<<~AD)
        Honda
        Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
        Mileage: High (120,000)
        Engine: Works
      AD
    end
  end
end
