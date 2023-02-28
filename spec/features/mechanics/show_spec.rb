require 'rails_helper'

RSpec.describe "Mechanics Show Page", type: :feature do

  let!(:fred) { Mechanic.create!(name: "Fred", years_experience: 4) }
  let!(:sixflags) { AmusementPark.create!(name: "Six Flags", admission_cost: 50) }

  let!(:deathcoaster) { sixflags.rides.create!(name: "Death Coaster", thrill_rating: 10, open: true) }
  let!(:freefaller) { sixflags.rides.create!(name: "Free Faller", thrill_rating: 9, open: true) }
  let!(:teacups) { sixflags.rides.create!(name: "Teacups", thrill_rating: 2, open: false) }


  describe 'As a user, when I visit a mechanic show page' do
    before do
      RideMechanic.create!(ride: deathcoaster, mechanic: fred)
      RideMechanic.create!(ride: freefaller, mechanic: fred)
      RideMechanic.create!(ride: teacups, mechanic: fred)

      visit "/mechanics/#{fred.id}"
    end
    it 'I see Mechanic info' do
      save_and_open_page
      expect(page).to have_content('Name: Fred')
      expect(page).to have_content('Years Experience: 4')

      within "#rides" do
        expect(page).to have_content('Rides Working On:')
        expect(page).to have_content('Death Coaster')
        expect(page).to have_content('Free Faller')
        expect(page).to have_content('Teacups')
      end
    end
  end
end