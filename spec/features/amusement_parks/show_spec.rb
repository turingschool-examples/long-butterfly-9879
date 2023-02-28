require 'rails_helper'

RSpec.describe "Amusement Park Show Page", type: :feature do
  let!(:sixflags) { AmusementPark.create!(name: "Six Flags", admission_cost: 50) }
  
  let!(:fred) { Mechanic.create!(name: "Fred", years_experience: 4) }
  let!(:marilyn) { Mechanic.create!(name: "Marilyn", years_experience: 22) }
  let!(:roger) { Mechanic.create!(name: "Roger", years_experience: 6) }
  let!(:jeffrey) { Mechanic.create!(name: "Jeffrey", years_experience: 10) }


  let!(:deathcoaster) { sixflags.rides.create!(name: "Death Coaster", thrill_rating: 10, open: true) }
  let!(:freefaller) { sixflags.rides.create!(name: "Free Faller", thrill_rating: 9, open: true) }
  let!(:teacups) { sixflags.rides.create!(name: "Teacups", thrill_rating: 2, open: false) }
  let!(:merrygoround) { sixflags.rides.create!(name: "Merry Go Round", thrill_rating: 1, open: false) }
  let!(:slingshot) { sixflags.rides.create!(name: "Slingshot", thrill_rating: 10, open: false) }


  describe 'As a Visitor, when I visit an Amusement Park show page' do
    before do
      RideMechanic.create!(ride: deathcoaster, mechanic: fred)
      RideMechanic.create!(ride: deathcoaster, mechanic: marilyn)

      RideMechanic.create!(ride: freefaller, mechanic: fred)
      RideMechanic.create!(ride: freefaller, mechanic: roger)

      RideMechanic.create!(ride: teacups, mechanic: fred)

      RideMechanic.create!(ride: slingshot, mechanic: marilyn)
      RideMechanic.create!(ride: slingshot, mechanic: roger)

      visit "/amusement_parks/#{sixflags.id}"
    end

    it 'I see Amusement Park info' do
      expect(page).to have_content("Amusement Park: Six Flags")
      expect(page).to have_content("Price of Admissions: $50.00")
      # save_and_open_page

      within "#mechanics" do
        expect(page).to have_content("Mechanics Currently Working on Rides:")
        expect(page).to have_css("Fred", count: 1)
        expect(page).to have_css('Marilyn', count: 1)
        expect(page).to have_css('Roger', count: 1)

        expect(page).to_not have_content('Jeffrey')
      end
    end
  end
end