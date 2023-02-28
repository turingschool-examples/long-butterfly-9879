require "rails_helper"

RSpec.describe "Mechanics Show Page" do
  context "Story 1" do
    describe 'As a user' do
      describe 'When I visit a mechanic show page' do
        it 'I see their name, years of experience, and the names of all rides they are working on' do
          six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

          hurler = six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
          scrambler = six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
          ferris = six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

          jim = Mechanic.create!(name: "Jim", years_experience: 10)

          RideMechanic.create!(ride: hurler, mechanic: jim)
          RideMechanic.create!(ride: ferris, mechanic: jim)

          visit mechanic_path(jim)

          expect(page).to have_content("Name: Jim")
          expect(page).to have_content("Years of Experience: 10")

          within("#mechanic_rides") {
            expect(page).to have_content("The Hurler")
            expect(page).to have_content("Ferris Wheel")
            expect(page).to_not have_content("The Scrambler")
          }
        end
      end
    end
  end
end