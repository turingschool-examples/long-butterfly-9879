require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many(:mechanic_rides) }
    it { should have_many(:mechanics).through(:mechanic_rides)}
  end

  describe "class methods" do 
    it "self.select_unique_mechanics" do 
      @amusement_park_1 = AmusementPark.create!(name: "Disney", admission_cost: 345)
      @mechanic_1 = Mechanic.create!(name: "Hady", years_experience: 5)
      @mechanic_2 = Mechanic.create!(name: "Malena", years_experience: 5)
      @ride1 = @amusement_park_1.rides.create!(name: "Kraken", thrill_rating: 3, open: true)
      @ride2 = @amusement_park_1.rides.create!(name: "Jungle Rush", thrill_rating: 10, open: false)
      @ride3 = @amusement_park_1.rides.create!(name: "Jump High", thrill_rating: 10, open: false)
      MechanicRide.create!(ride_id: @ride1.id, mechanic_id: @mechanic_1.id)
      MechanicRide.create!(ride_id: @ride2.id, mechanic_id: @mechanic_1.id)
      MechanicRide.create!(ride_id: @ride1.id, mechanic_id: @mechanic_2.id)
      MechanicRide.create!(ride_id: @ride3.id, mechanic_id: @mechanic_2.id)

      expect(@amusement_park_1.rides.select_unique_mechanics).to eq([@mechanic_1.name, @mechanic_2.name])

    end
  end
end