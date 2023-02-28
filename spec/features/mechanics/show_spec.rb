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
        @jill = Mechanics.create!(name: "Jill", years_experience: 7)
        
        MachineRide.create!(mechanic: @steve, ride: @ride1)
        MachineRide.create!(mechanic: @steve, ride: @ride2)
        MachineRide.create!(mechanic: @jill, ride: @ride1)
      
        visit "/mechanics/#{@steve.id}"

        expect(page).to have_content("Name: Steve")
        expect(page).to have_content("Years of Experience: 5")
        expect(page).to have_content("The Screamer")
        expect(page).to have_content("The Drooler")
        expect(page).to_not have_content("The Whopper(sponsored by BK)")
        expect(page).to_not have_content("Name: Jill")

      end
    end
  end
end