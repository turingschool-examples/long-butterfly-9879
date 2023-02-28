require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it {should have_many(:mechanics).through(:rides)}
  end

  describe 'instance methods' do
    it "::unique_names" do
      @amusement_park = AmusementPark.create!(name: "Six Flags", admission_cost: 100)
      @tower = @amusement_park.rides.create!(name: "Tower of terror", thrill_rating: 7, open: true)
      @spinner = @amusement_park.rides.create!(name: "Spinny Thing", thrill_rating: 7, open: true)
      @twirler = @amusement_park.rides.create!(name: "Twirly Thing", thrill_rating: 10, open: true)
      @coaster = @amusement_park.rides.create!(name: "Rollercoaster", thrill_rating: 1, open: true)
      @steve = Mechanic.create!(name: "Steve", years_experience: 7)
      @bob = Mechanic.create!(name: "Bob", years_experience: 7)
      MechanicRide.create!(ride: @coaster, mechanic: @steve)
      MechanicRide.create!(ride: @tower, mechanic: @steve)
      MechanicRide.create!(ride: @twirler, mechanic: @bob)

      expect(@amusement_park.unique_names).to eq([@steve, @bob])
    end
  end
end