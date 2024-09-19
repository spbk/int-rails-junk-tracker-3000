require "rails_helper"

describe "AdBuilder" do
  describe "#create_ad" do
    let(:registration_id) { "415Hn3JTu7obqNj151gmuscoq0kWCy" }

    before do
      allow(VehicleRegistrationService)
        .to receive(:register_vehicle)
        .and_return(registration_id)
    end

    describe "when vehicle is a Sedan" do
      it "looks like this" do
        vehicle = Sedan.create!(
          nickname: "2020 Honda Civic",
          mileage: 5134)

        Engine.create!(vehicle: vehicle)

        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          2020 Honda Civic
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Low (5,134)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Coupe" do
      it "looks like this" do
        vehicle = Coupe.create!(
          nickname: "2021 Honda Civic",
          mileage: 21980)

        Engine.create!(vehicle: vehicle)

        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          2021 Honda Civic
          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Medium (21,980)
          Engine: Works
        AD
      end
    end

    describe "when vehicle is a Mini-Van" do
      it "looks like this" do
        vehicle = MiniVan.create!(
          nickname: "2009 Dodge Caravan",
          mileage: 5134)

        Door.create!([
          { vehicle: vehicle },
          { vehicle: vehicle },
          { vehicle: vehicle, sliding: true},
          { vehicle: vehicle, sliding: true}
        ])

        Engine.create!(vehicle: vehicle)

        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          Looking for a Mini-Van? Look no further!

          ~~~ 2009 Dodge Caravan ~~~

          Registration number: 415Hn3JTu7obqNj151gmuscoq0kWCy
          Mileage: Low (5,134)
          Engine: Works
          Regular Doors: 2
          Sliding Doors: 2
        AD
      end
    end

    describe "when vehicle is a Motorcycle" do
      it "looks like this" do
        vehicle = Motorcycle.create!(
          nickname: "2019 Ducati Sportbike Motorcycle PANIGALE V4 SPECIALE",
          mileage: 105777)

        Engine.create!(vehicle: vehicle)
        Seat.create!(vehicle: vehicle, status: "fixable")

        expect(AdBuilder.create_ad(vehicle)).to eql(<<~AD)
          ~~~ Motorcycle for Sale ~~~

          2019 Ducati Sportbike Motorcycle PANIGALE V4 SPECIALE

          Registration number:
          415Hn3JTu7obqNj151gmuscoq0kWCy

          Mileage:
          High (105,777)

          Engine:
          Works

          Seat:
          Fixable
        AD
      end
    end
  end
end