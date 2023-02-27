require 'rails_helper'

describe 'As a visitor', type: :feature do
  describe "When I visit an amusement park's show page" do
    before(:each) do
      @jasmine_world = AmusementPark.create!(name: "Jasmine World", admission_cost: 25)
      @ivan_world = AmusementPark.create!(name: "Ivan World", admission_cost: 12)

      @mechanic1 = Mechanic.create!(name: "Rostam", years_experience: 2)
      @mechanic2 = Mechanic.create!(name: "Jolly", years_experience: 5)
      @mechanic3 = Mechanic.create!(name: "Paul", years_experience: 9)

      @ferris_wheel = @jasmine_world.rides.create!(name: "Ferris Wheel", thrill_rating: 1, open: true)
      @roller_coaster = @jasmine_world.rides.create!(name: "Roller Coaster", thrill_rating: 8, open: true)
      @haunted_house = @jasmine_world.rides.create!(name: "Haunted House", thrill_rating: 10, open: true)
      @bumper_cars= @jasmine_world.rides.create!(name: "Bumper Cars", thrill_rating: 4, open: false)
      @swings = @ivan_world.rides.create!(name: "Swings", thrill_rating: 2, open: true)

      RideMechanic.create!(mechanic: @mechanic1, ride: @ferris_wheel)
      RideMechanic.create!(mechanic: @mechanic1, ride: @roller_coaster)
      RideMechanic.create!(mechanic: @mechanic2, ride: @haunted_house)
      RideMechanic.create!(mechanic: @mechanic1, ride: @bumper_cars)  
      RideMechanic.create!(mechanic: @mechanic3, ride: @swings)
    end

    it "I see the name and price of admissions for that amusement park" do
      visit "/amusement_parks/#{@jasmine_world.id}"

      expect(page).to have_content("Amusement Park: #{@jasmine_world.name}")
      expect(page).to_not have_content(@ivan_world.name)
      expect(page).to have_content("Admission Cost: $25.00")
    end

    it "I see the unique names of all mechanics that are working on that parks' rides" do
      visit "/amusement_parks/#{@jasmine_world.id}"

      within "#mechanics" do
        expect(page).to have_content(@mechanic1.name, count: 1)
        expect(page).to have_content(@mechanic2.name, count: 1)
        expect(page).to_not have_content(@mechanic3.name)
      end
    end
  end
end