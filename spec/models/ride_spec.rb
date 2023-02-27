require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many (:ride_mechanics) }
    it { should have_many(:mechanics).through(:ride_mechanics) }
  end

  describe 'class_methods' do
    before(:each) do
      @jasmine_world = AmusementPark.create!(name: "Jasmine World", admission_cost: 25)

      @mechanic1 = Mechanic.create!(name: "Rostam", years_experience: 2)
      @mechanic2 = Mechanic.create!(name: "Jolly", years_experience: 5)
      @mechanic3 = Mechanic.create!(name: "Hailey", years_experience: 13)

      @ferris_wheel = @jasmine_world.rides.create!(name: "Ferris Wheel", thrill_rating: 1, open: true)
      @roller_coaster = @jasmine_world.rides.create!(name: "Roller Coaster", thrill_rating: 8, open: true)
      @haunted_house = @jasmine_world.rides.create!(name: "Haunted House", thrill_rating: 10, open: true)
      @bumper_cars= @jasmine_world.rides.create!(name: "Bumper Cars", thrill_rating: 4, open: false)
      @swings = @jasmine_world.rides.create!(name: "Swings", thrill_rating: 2, open: true)

      RideMechanic.create!(mechanic: @mechanic1, ride: @ferris_wheel)
      RideMechanic.create!(mechanic: @mechanic1, ride: @roller_coaster)
      RideMechanic.create!(mechanic: @mechanic2, ride: @haunted_house)
      RideMechanic.create!(mechanic: @mechanic1, ride: @bumper_cars)  
      RideMechanic.create!(mechanic: @mechanic3, ride: @haunted_house)
      RideMechanic.create!(mechanic: @mechanic3, ride: @roller_coaster)
      RideMechanic.create!(mechanic: @mechanic3, ride: @swings)
      RideMechanic.create!(mechanic: @mechanic2, ride: @bumper_cars)  
    end

    describe '#average_mechanic_experience' do
      it "returns a list of rides with average mechanic experience for each ride, ordered from least to most experience" do
        expect(Ride.average_mechanic_experience).to eq([@ferris_wheel, @bumper_cars, @roller_coaster, @haunted_house, @swings])
        
        expect(@jasmine_world.rides.average_mechanic_experience.first.average).to eq(2)
        expect(@jasmine_world.rides.average_mechanic_experience.second.average).to eq(3.5)
        expect(@jasmine_world.rides.average_mechanic_experience.last.average).to eq(13)
      end
    end
  end
end