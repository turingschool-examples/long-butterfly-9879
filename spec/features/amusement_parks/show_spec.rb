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
      RideMechanic.create!(mechanic: @mechanic2, ride: @ferris_wheel)
      RideMechanic.create!(mechanic: @mechanic1, ride: @haunted_house)
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

    it "I see a list of all the park's rides" do
      visit "/amusement_parks/#{@jasmine_world.id}"

      within "#rides" do
        expect(page).to have_content(@ferris_wheel.name)
        expect(page).to have_content(@roller_coaster.name)
        expect(page).to have_content(@haunted_house.name)
        expect(page).to have_content(@bumper_cars.name)
        expect(page).to_not have_content(@swings.name)
      end
    end

    it "Next to each ride name, I see the average experience of the mechanics working on the ride" do
      mechanic4 = Mechanic.create!(name: "Hailey", years_experience: 13)

      RideMechanic.create!(mechanic: mechanic4, ride: @haunted_house)
      RideMechanic.create!(mechanic: mechanic4, ride: @roller_coaster)

      visit "/amusement_parks/#{@jasmine_world.id}"

      within '#rides' do
        expect(page).to have_content("#{@ferris_wheel.name} - 3.5 years experience(average)")
        expect(page).to have_content("#{@roller_coaster.name} - 7.5 years experience(average)")
        expect(page).to have_content("#{@haunted_house.name} - 6.67 years experience(average)")
        expect(page).to have_content("#{@bumper_cars.name} - 2.0 years experience(average)")
      end
    end

    it "lists the rides in order of average mechanic experience (least to most)" do
      mechanic4 = Mechanic.create!(name: "Hailey", years_experience: 13)

      RideMechanic.create!(mechanic: mechanic4, ride: @haunted_house)
      RideMechanic.create!(mechanic: mechanic4, ride: @roller_coaster)

      visit "/amusement_parks/#{@jasmine_world.id}"

      within '#rides' do
        expect(@bumper_cars.name).to appear_before(@ferris_wheel.name)
        expect(@ferris_wheel.name).to appear_before(@haunted_house.name)
        expect(@haunted_house.name).to appear_before(@roller_coaster.name)
      end
    end
  end
end