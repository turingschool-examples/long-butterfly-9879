require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:rides) }
  end

  describe 'instance methods' do
    describe '#unique_mechanics' do
      before(:each) do
        @jasmine_world = AmusementPark.create!(name: "Jasmine World", admission_cost: 25)
  
        @mechanic1 = Mechanic.create!(name: "Rostam", years_experience: 2)
        @mechanic2 = Mechanic.create!(name: "Jolly", years_experience: 5)
  
        @ferris_wheel = @jasmine_world.rides.create!(name: "Ferris Wheel", thrill_rating: 1, open: true)
        @roller_coaster = @jasmine_world.rides.create!(name: "Roller Coaster", thrill_rating: 8, open: true)
        @haunted_house = @jasmine_world.rides.create!(name: "Haunted House", thrill_rating: 10, open: true)
        @bumper_cars= @jasmine_world.rides.create!(name: "Bumper Cars", thrill_rating: 4, open: false)
        @swings = @jasmine_world.rides.create!(name: "Swings", thrill_rating: 2, open: true)
  
        RideMechanic.create!(mechanic: @mechanic1, ride: @ferris_wheel)
        RideMechanic.create!(mechanic: @mechanic1, ride: @roller_coaster)
        RideMechanic.create!(mechanic: @mechanic2, ride: @haunted_house)
        RideMechanic.create!(mechanic: @mechanic1, ride: @bumper_cars)  
      end

      it 'returns a list of unique mechanics for an amusement park' do
        expect(@jasmine_world.unique_mechanics).to eq([@mechanic1, @mechanic2])
        
        @mechanic3 = Mechanic.create!(name: "Paul", years_experience: 9)

        RideMechanic.create!(mechanic: @mechanic3, ride: @swings)
        RideMechanic.create!(mechanic: @mechanic3, ride: @bumper_cars)

        expect(@jasmine_world.unique_mechanics).to eq([@mechanic1, @mechanic2, @mechanic3])
      end
    end
  end 
end