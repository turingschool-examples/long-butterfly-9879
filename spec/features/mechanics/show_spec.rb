require "rails_helper"

RSpec.describe "Mechanics Show Page" do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jim = Mechanic.create!(name: "Jim", years_experience: 10)

    RideMechanic.create!(ride: @hurler, mechanic: @jim)
    RideMechanic.create!(ride: @ferris, mechanic: @jim)

    visit mechanic_path(@jim)
  end

  context "Story 1" do
    describe 'As a user' do
      describe 'When I visit a mechanic show page' do
        it 'I see their name, years of experience, and the names of all rides they are working on' do
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

  context "Story 2" do
    describe 'As a user' do
      describe 'When I visit a mechanic show page' do
        it 'I see a form to add a ride to their workload' do
          within("#add_ride") { 
            expect(page).to have_field(:ride_id) 
            expect(page).to have_button("Submit")
          }
        end

        it "When I fill in the form with an id of an existing ride and click Submit, I’m taken back to that mechanic's show page
          and I see the name of that newly added ride on this mechanic's show page" do
          
          within("#add_ride") {
            fill_in :ride_id, with: @scrambler.id
            click_button "Submit"
          }

          expect(current_path).to eq(mechanic_path(@jim))

          within("#mechanic_rides") { expect(page).to have_content("The Scrambler") }
        end
      end
    end
  end
end