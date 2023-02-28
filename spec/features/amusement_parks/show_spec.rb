require "rails_helper"

RSpec.describe "Amusement Parks Show Page" do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jim = Mechanic.create!(name: "Jim", years_experience: 10)
    @bob = Mechanic.create!(name: "Bob", years_experience: 15)
    @adam = Mechanic.create!(name: "Adam", years_experience: 3)
  end

  context 'Story 3' do
    describe 'As a visitor' do
      describe "When I visit an amusement park’s show page" do
        it "can see the name and price of admissions for that amusement park and a list of all unique mechanics that are working on that park's rides" do
          RideMechanic.create!(ride: @hurler, mechanic: @jim)
          RideMechanic.create!(ride: @ferris, mechanic: @jim)
          RideMechanic.create!(ride: @scrambler, mechanic: @bob)

          visit amusement_park_path(@six_flags)

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

  context 'Extension - Amusement Park Rides' do
    describe 'As a visitor' do
      describe "When I visit an amusement park's show page" do
        it "can see a list of all of the park's rides, including the average experience of mechanics on the ride, ordered by average experience" do
          RideMechanic.create!(ride: @hurler, mechanic: @jim)
          RideMechanic.create!(ride: @hurler, mechanic: @bob)

          RideMechanic.create!(ride: @scrambler, mechanic: @bob)
          RideMechanic.create!(ride: @scrambler, mechanic: @adam)
          
          RideMechanic.create!(ride: @ferris, mechanic: @jim)
          RideMechanic.create!(ride: @ferris, mechanic: @adam)

          

          visit amusement_park_path(@six_flags)

          within("#rides") {
            expect("The Hurler - Average Years of Experience for Mechanics: 12.5").to appear_before("The Scrambler - Average Years of Experience for Mechanics: 9.0")
            expect("The Scrambler - Average Years of Experience for Mechanics: 9.0").to appear_before("Ferris Wheel - Average Years of Experience for Mechanics: 6.5")
          }
        end
      end
    end
  end
end