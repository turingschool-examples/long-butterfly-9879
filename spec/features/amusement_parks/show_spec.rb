require 'rails_helper'

RSpec.describe '/amusement_parks/:id' do
  let!(:wonder) { AmusementPark.create!(name: "WonderWorld", admission_cost: 70)}
  let!(:crazy) { wonder.rides.create!(name: "Crazy", thrill_rating: 5, open: false)}
  let!(:twister) { wonder.rides.create!(name: "Twister", thrill_rating: 7, open: false)}
  let!(:monster) { wonder.rides.create!(name: "Monster", thrill_rating: 7, open: false)}

  let!(:john) {Mechanic.create!(name: "John", years_experience: 10)}
  let!(:smith) {Mechanic.create!(name: "Smith", years_experience: 8)}

  before do
    RideMechanic.create!(ride: crazy, mechanic: john)
    RideMechanic.create!(ride: twister, mechanic: john)
    RideMechanic.create!(ride: monster, mechanic: john) 

    RideMechanic.create!(ride: crazy, mechanic: smith) 
    RideMechanic.create!(ride: twister, mechanic: smith) 
  end

  describe "when I visit the amusement_park show page" do
    it 'should display the amusement park attributes, all mechanics working on rides' do
      visit "/amusement_parks/#{wonder.id}"

      expect(page).to have_content("#{wonder.name}")
      expect(page).to have_content("#{wonder.admission_cost}")
      expect(page).to have_content("#{john.name}")
      expect(page).to have_content("#{smith.name}")
    end
  end
end