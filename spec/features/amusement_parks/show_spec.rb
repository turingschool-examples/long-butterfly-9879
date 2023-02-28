require "rails_helper"

RSpec.describe "Amusement Parks Show Page" do
  context 'Story 3' do
    describe 'As a visitor' do
      describe "When I visit an amusement park’s show page" do
        it "can see the name and price of admissions for that amusement park and a list of all unique mechanics that are working on that park's rides" do
          six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      
          hurler = six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
          scrambler = six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
          ferris = six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
      
          jim = Mechanic.create!(name: "Jim", years_experience: 10)
          bob = Mechanic.create!(name: "Bob", years_experience: 15)
          adam = Mechanic.create!(name: "Bob", years_experience: 0)
      
          RideMechanic.create!(ride: hurler, mechanic: jim)
          RideMechanic.create!(ride: ferris, mechanic: jim)
          RideMechanic.create!(ride: scrambler, mechanic: bob)
      
          visit amusement_park_path(six_flags)

          expect(page).to have_content("Amusement Park: Six Flags")          
          expect(page).to have_content("Price of Admissions: 75")
          
          within("#unique_mechanics") {
            expect(page).to have_content("Jim")
            expect(page).to have_content("Bob")
          }
        end
      end
    end
  end
end