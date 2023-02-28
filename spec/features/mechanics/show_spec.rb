require 'rails_helper'

RSpec.describe 'mechanic/show', type: :feature do

  describe 'As a user,' do
    context 'When I visit a mechanic show page' do
      it 'I see their name, years of experience, and the names of all rides they are working on' do
        @park = AmusementPark.create!(name: 'Wally World', admission_cost: 100)
        @ride1 = @park.rides.create!(name: "The Screamer", thrill_rating: 8, open: true)
        @ride2 = @park.rides.create!(name: "The Drooler", thrill_rating: 2, open: false)
        @ride3 = @park.rides.create!(name: "The Whopper(sponsored by BK)", thrill_rating: 1, open: true)
        @steve = Mechanic.create!(name: "Steve", years_experience: 5)
        @jill = Mechanic.create!(name: "Jill", years_experience: 7)
        
        MechanicRide.create!(mechanic: @steve, ride: @ride1)
        MechanicRide.create!(mechanic: @steve, ride: @ride2)
        MechanicRide.create!(mechanic: @jill, ride: @ride1)
        visit "/mechanics/#{@steve.id}"
        
        expect(page).to have_content("Name: Steve")
        expect(page).to have_content("Years of Experience: 5")
        expect(page).to have_content("The Screamer")
        expect(page).to have_content("The Drooler")
        expect(page).to_not have_content("The Whopper(sponsored by BK)")
        expect(page).to_not have_content("Name: Jill")
      end

      it 'I see a form to add a ride to their workload' do
        @park = AmusementPark.create!(name: 'Wally World', admission_cost: 100)
        @ride1 = @park.rides.create!(name: "The Screamer", thrill_rating: 8, open: true)
        @ride2 = @park.rides.create!(name: "The Drooler", thrill_rating: 2, open: false)
        @ride3 = @park.rides.create!(name: "The Whopper(sponsored by BK)", thrill_rating: 1, open: true)
        @steve = Mechanic.create!(name: "Steve", years_experience: 5)
        MechanicRide.create!(mechanic: @steve, ride: @ride1)
        MechanicRide.create!(mechanic: @steve, ride: @ride2)
        visit "/mechanics/#{@steve.id}"

        expect(page).to have_field("Add Ride")
        expect(page).to have_button("Submit")
      end

      context 'When I fill in that field with an id of an existing ride and click Submit' do
        it "I’m taken back to that mechanic's show page and I see the name of that newly added ride on this mechanic's show page" do
          park = AmusementPark.create!(name: 'Wally World', admission_cost: 100)
          ride1 = park.rides.create!(name: "The Screamer", thrill_rating: 8, open: true)
          ride2 = park.rides.create!(name: "The Drooler", thrill_rating: 2, open: false)
          ride3 = park.rides.create!(name: "The Whopper(sponsored by BK)", thrill_rating: 1, open: true)
          steve = Mechanic.create!(name: "Steve", years_experience: 5)
          MechanicRide.create!(mechanic_id: steve.id, ride_id: ride1.id)
          MechanicRide.create!(mechanic_id: steve.id, ride_id: ride2.id)
          visit "/mechanics/#{steve.id}"

          fill_in 'Add Ride', with: "#{ride3.id}"
        
          # require 'pry'; binding.pry
          click_on 'Submit'
          expect(current_path).to be("/mechanics/#{steve.id}")
          expect(page).to have_content("The Whopper(sponsored by BK)")
        end
      end
    end
  end
end