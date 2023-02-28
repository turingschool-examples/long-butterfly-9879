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

    visit "/mechanics/#{@mechanic.id}"
  end
    describe "User Story 1" do 
      it "shows the visitor the mechanic's name, years of experience, and the names of all rides they are working on" do
        expect(page).to have_content("Mechanic: Dawson")
        expect(page).to have_content("Years of experience: 5")

        within("#mechanic-rides") {
          expect(page).to have_content('The Hurler')
          expect(page).to have_content('The Scrambler')
        }
      end
    end

    describe "User Story 2" do
      it "shows the visitor a form to add a ride to their workload" do 
        within("#new-ride-form") {
          expect(page).to have_content("Ride Id:")
          expect(page).to have_field("ride_id")
          expect(page).to have_button("Submit")
        }
      end

      it "allows the visitor to fill in that field with an id of an existing ride and click Submit. 
      They are then taken back to that mechanic's show page, and see the name of that newly added ride on the mechanic's show page" do
        fill_in "ride_id", with: @ferris.id

        click_on "Submit"

        expect(current_path).to eq(mechanic_path(@mechanic))

        within("#mechanic-rides") {
          expect(page).to have_content('The Hurler')
          expect(page).to have_content('The Scrambler')
          expect(page).to have_content('Ferris Wheel')
        }
      end
    end
end