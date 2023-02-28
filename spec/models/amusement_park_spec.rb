require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanic_rides).through(:rides) }
    it { should have_many(:mechanics).through(:mechanic_rides)}
  end

  describe 'instance methods' do
    before(:each) do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 50)
      @mechanic = Mechanic.create!(name: 'Kara Smith', years_of_experience: 11)
      @mechanic2 = Mechanic.create!(name: 'Crusty Old Guy', years_of_experience: 7)
      @mechanic3 = Mechanic.create!(name: 'Crusty Old Guy', years_of_experience: 20)
      @mechanic4 = Mechanic.create!(name: 'Overly Eager New Guy', years_of_experience: 1)
      @ride1 = Ride.create!(name: 'The Frog Hopper', thrill_rating: 2, open: true, amusement_park_id: @six_flags.id)
      @ride2 = Ride.create!(name: 'Fahrenheit', thrill_rating: 5, open: true, amusement_park_id: @six_flags.id)
      @ride3 = Ride.create!(name: 'The Kiss Raise', thrill_rating: 4, open: false, amusement_park_id: @six_flags.id)
      @ride4 = Ride.create!(name: 'Bumper Cars of Doom', thrill_rating: 400, open: true, amusement_park_id: @six_flags.id)
      MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride2.id)
      MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride3.id)
      MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride2.id)
      MechanicRide.create!(mechanic_id: @mechanic3.id, ride_id: @ride2.id)
      MechanicRide.create!(mechanic_id: @mechanic4.id, ride_id: @ride4.id)
    end

    describe '#rides_with_average_mech_years' do
      it 'returns an array of rides with the average years of experience ofhe mechanics working on them sorted by mos tt experienced' do
        expect(@six_flags.rides_with_average_mech_years).to eq([@ride2, @ride1, @ride3, @ride4])
      end
    end
  end
end