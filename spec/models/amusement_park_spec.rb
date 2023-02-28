require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanic_rides).through(:rides) }
    it { should have_many(:mechanics).through(:mechanic_rides) }
  end

  describe '#instance methods' do
    before(:each) do
      @amusement_park = AmusementPark.create!(name: "Amusement Park", admission_cost: 50)

      @ride_1 = Ride.create!(name: "Ride 1", thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
      @ride_2 = Ride.create!(name: "Ride 2", thrill_rating: 5, open: true, amusement_park_id: @amusement_park.id)
      @ride_3 = Ride.create!(name: "Ride 3", thrill_rating: 1, open: true, amusement_park_id: @amusement_park.id)
      @ride_4 = Ride.create!(name: "Ride 4", thrill_rating: 2, open: false, amusement_park_id: @amusement_park.id)

      @tech_1 = Mechanic.create!(name: "Bill", years_experience: 4)
      @tech_2 = Mechanic.create!(name: "Ted", years_experience: 7)

      MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_1.id)
      MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_2.id)
      MechanicRide.create!(mechanic_id: @tech_2.id, ride_id: @ride_3.id)
      MechanicRide.create!(mechanic_id: @tech_2.id, ride_id: @ride_4.id)
      
      MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_4.id)
    end

    describe '#park_mechanics' do
      it "returns a unique list of techs working at the park" do
        expect(@amusement_park.park_mechanics).to eq([@tech_1.name, @tech_2.name])
      end
    end
  end
end