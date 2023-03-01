require 'rails_helper'

RSpec.describe AmusementPark, type: :model do

  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Park of Amusement", admission_cost: 500)
    @ride_1 = @amusement_park.rides.create!(name: "ride_1", thrill_rating: 2, open: true)
    @ride_2 = @amusement_park.rides.create!(name: "ride_2", thrill_rating: 3, open: true)
    @ride_3 = @amusement_park.rides.create!(name: "ride_3", thrill_rating: 4, open: true)
    @ride_4 = @amusement_park.rides.create!(name: "ride_4", thrill_rating: 5, open: false)
    @ride_5 = @amusement_park.rides.create!(name: "ride_5", thrill_rating: 6, open: false)
    @mechanic_1 = Mechanic.create!(name: "Guy the mechanic", years_experience: 22)
    @mechanic_2 = Mechanic.create!(name: "Girl the mechanic", years_experience: 33)
    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_1.id)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_2.id)
    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_3.id)
    @mechanic_ride_4 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_4.id)
    # @mechanic_ride_5 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_5.id)
  end

  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanic_rides)}
    it { should have_many(:mechanics)}
  end

  describe "#park_mechanics" do
    it 'is a unige list of mechanics for a park' do
      expect(@amusement_park.park_mechanics).to eq([@mechanic_1, @mechanic_2])
    end
  end
end