require 'rails_helper'

RSpec.describe 'Mechanic show page' do 
  describe 'As a visitor' do 
    describe 'When I visit a mechanic show page' do 
      it 'will have their name, years of experience, and the names of all rides they are working on' do 
        park = AmusementPark.create!(name: "Six Flags", admission_cost: 10)
        ride1 = park.rides.create!(name: "Tower of doom", thrill_rating: 10, open: true)
        ride2 = park.rides.create!(name: "Splash Mountain", thrill_rating: 10, open: true)
        mechanic = Mechanic.create!(name: "Brian", years_experience: 0)
        RideMechanic.create!(mechanic: mechanic, ride: ride1)
        RideMechanic.create!(mechanic: mechanic, ride: ride2)
        # require 'pry'; binding.pry
        visit "/mechanics/#{mechanic.id}"

        expect(page).to have_content("Name: #{mechanic.name}")
        expect(page).to have_content("Years of Experience: #{mechanic.years_experience}")
        expect(page).to have_content("Rides:")
        expect(page).to have_content("#{ride1.name}")

        expect(page).to have_content("#{ride1.name}")
      end
    end
  end
end