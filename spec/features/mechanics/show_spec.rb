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
    end

    it 'I see their name, years of experience, and the names of all rides they are working on' do
      visit "/mechanics/#{@mechanic1.id}"

      expect(page).to have_content("Mechanic: #{@mechanic1.name}")
      expect(page).to_not have_content(@mechanic2.name)
      expect(page).to have_content("Years of Experience: #{@mechanic1.years_experience}")

      within "#rides" do
        expect(page).to have_content(@ferris_wheel.name)
        expect(page).to have_content(@roller_coaster.name)
        expect(page).to have_content(@bumper_cars.name)
        expect(page).to_not have_content(@haunted_house.name)
      end
    end

    it 'I see a form to add a ride to their workload' do
      visit "/mechanics/#{@mechanic1.id}"

      within "#add_ride" do
        expect(page).to have_field :ride_id
        expect(page).to have_button "Submit"
      end
    end

    it "When I fill in that field with an id of an existing ride and click Submit, I'm take back to the mechanic's show page" do
      visit "/mechanics/#{@mechanic1.id}"

      within "#add_ride" do
        fill_in :ride_id, with: "#{@haunted_house.id}"
        click_button "Submit"

        expect(current_path).to eq(mechanic_path(@mechanic1))
      end
    end

    it "When I fill in the field with an id and click Submit, I'm taken back to the mechanic show page and see the newly added ride" do
      visit "/mechanics/#{@mechanic1.id}"

      within "#add_ride" do
        fill_in :ride_id, with: "#{@haunted_house.id}"
        click_button "Submit"
      end

      within "#rides" do
        expect(page).to have_content(@haunted_house.name)
      end
    end
  end
end