require 'rails_helper'

RSpec.describe "The Mechanic's Show Page" do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @mechanic = Mechanic.create!(name: "Dawson", years_experience: 5)

    @ride_mechanic_1 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic.id)
    @ride_mechanic_2 = RideMechanic.create!(ride_id: @scrambler.id, mechanic_id: @mechanic.id)
    @ride_mechanic_3 = RideMechanic.create!(ride_id: @ferris.id, mechanic_id: @mechanic.id)

    visit "/mechanics/#{@mechanic.id}"
  end
    describe "User Story 1" do 
      it "When I visit a mechanic show page I see their name, years of experience, and the names of all rides they are working on" do
        expect(page).to have_content("Mechanic's Name: Dawson")
        expect(page).to have_content("Years of experience: 5")

        within("#mechanic-rides") {
          expect(page).to have_content('The Hurler')
          expect(page).to have_content('The Scrambler')
          expect(page).to have_content('Ferris Wheel')
        }
      end
    end
end