require 'rails_helper'

RSpec.describe '/mechanics/:id', type: :feature do
  before(:each) do 
    @jack_mechanic = Mechanic.create!(name: "Jack Frost", years_experience: 12)

    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
    @water_world = @universal.rides.create!(name: 'Water World', thrill_rating: 7, open: true)

    MechanicRide.create!(mechanic: @jack_mechanic, ride: @ferris)
    MechanicRide.create!(mechanic: @jack_mechanic, ride: @water_world)
  end 

  describe "As a user, when I visit a mechanic's show page" do
    # User Story 1
    it "I see their name, years_experience, & names of all rides they're working on" do 
      visit "/mechanics/#{@jack_mechanic.id}"

      expect(page).to have_content("Mechanic: #{@jack_mechanic.name}")
      expect(page).to have_content("Years of Experience: #{@jack_mechanic.years_experience}")
      expect(page).to have_content("Current rides they’re working on:")
      expect(page).to have_content("#{@ferris.name}")
      expect(page).to have_content("#{@water_world.name}")

      expect(page).to_not have_content("#{@scrambler.name}")
    end

    # User Story 2
    it "I see a form to add a ride to their workload" do 
      visit "/mechanics/#{@jack_mechanic.id}"

      expect(page).to have_content("Add a ride to workload:")
      expect(page).to have_field(:ride_id)
      expect(page).to have_button("Submit")
    end

    # User Story 2
    it "I fill in that form with an id of an exsiting ride, click 'Submit', I return to page & see new ride name" do 
      visit "/mechanics/#{@jack_mechanic.id}"

      expect(page).to_not have_content("#{@jaws.name}")
      
      fill_in("Ride Id:", with: "#{@jaws.id}")
      click_button("Submit")

      expect(current_path).to eq("/mechanics/#{@jack_mechanic.id}")
      expect(page).to have_content("#{@jaws.name}")
    end
  end
end
