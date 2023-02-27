require 'rails_helper'

describe 'As a user', type: :feature do
  describe 'When I visit a mechanic show page' do
    before(:each) do
      @jasmine_world = AmusementPark.create!(name: "Jasmine World", admission_cost: 2500)

      @mechanic1 = Mechanic.create!(name: "Rostam", years_experience: 2)
      @mechanic2 = Mechanic.create!(name: "Jolly", years_experience: 5)

      @ferris_wheel = @jasmine_world.rides.create!(name: "Ferris Wheel", thrill_rating: 1, open: true)
      @roller_coaster = @jasmine_world.rides.create!(name: "Roller Coaster", thrill_rating: 8, open: true)
      @haunted_house = @jasmine_world.rides.create!(name: "Haunted House", thrill_rating: 10, open: true)
      @bumper_cars= @jasmine_world.rides.create!(name: "Bumper Cars", thrill_rating: 4, open: false)

      RideMechanic.create!(mechanic: @mechanic1, ride: @ferris_wheel)
      RideMechanic.create!(mechanic: @mechanic1, ride: @roller_coaster)
      RideMechanic.create!(mechanic: @mechanic2, ride: @haunted_house)
      RideMechanic.create!(mechanic: @mechanic1, ride: @bumper_cars)
      RideMechanic.create!(mechanic: @mechanic1, ride: @haunted_house)      
    end

    it 'I see their name, years of experience, and the names of all rides they are working on' do
      visit "/mechanics/#{@mechanic1.id}"

      expect(page).to have_content(@mechanic1.name)
      expect(page).to_not have_content(@mechanic2.name)
      expect(page).to have_content("Years of Experience: #{@mechanic1.years_experience}")

      within "#rides" do
        expect(page).to have_content(@ferris_wheel.name)
        expect(page).to have_content(@roller_coaster.name)
        expect(page).to have_content(@bumper_cars.name)
        expect(page).to have_content(@haunted_house.name)
      end
    end
  end
end