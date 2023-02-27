require 'rails_helper'

RSpec.describe '/mechanics/id', type: :feature do
  before(:each) do 
    @jack_mechanic = Mechanic.create!(name: "Jack Mechanic", years_experience: 12)

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

  describe "when I visit a mechanic show page" do
    it "I see their name, years_experience, & names of all rides they're working on" do 
      visit "/mechanics/#{@jack_mechanic.id}"

      expect(page).to have_content("#{@jack_mechanic.name}'s Page")
      expect(page).to have_content("Years of Experience: #{@jack_mechanic.years_experience}")
      expect(page).to have_content("Currently Working On:")
      expect(page).to have_content("#{@ferris.name}")
      expect(page).to have_content("#{@water_world.name}")
save_and_open_page
      expect(page).to_not have_content("#{@jaws.name}")
    end
  end
end
