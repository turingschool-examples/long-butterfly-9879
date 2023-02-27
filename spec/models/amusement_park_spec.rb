require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:rides) }
  end

  describe "instance methods" do
    before :each do
      @park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @ride1 = @park.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
      @ride2 = @park.rides.create!(name: "Tower of Doom", thrill_rating: 10, open: true)
      @ride3 = @park.rides.create!(name: "Tea Cups", thrill_rating: 3, open: true)
      @mechanic1 = Mechanic.create!(name: "Kara Smith", years_experience: 11)
      @mechanic2 = Mechanic.create!(name: "Karl Smits", years_experience: 1)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
      MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride3.id)
      MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride3.id)
    end

    it "#park_mechanics" do
      expect(@park.park_mechanics).to eq([@mechanic1, @mechanic2])
    end
  end
end