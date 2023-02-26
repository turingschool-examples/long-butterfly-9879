require 'rails_helper'

RSpec.describe '/mechanic/:id' do
  let!(:wonder) { AmusementPark.create!(name: "WonderWorld", admission_cost: 70)}
  let!(:crazy) { wonder.rides.create!(name: "Crazy", thrill_rating: 5, open: false)}
  let!(:twister) { wonder.rides.create!(name: "Twister", thrill_rating: 7, open: false)}
  let!(:monster) { wonder.rides.create!(name: "Monster", thrill_rating: 7, open: false)}

  let!(:john) {Mechanic.create!(name: "John", years_experience: 10)}

  before do
    RideMechanic.create!(ride: crazy, mechanic: john)
    RideMechanic.create!(ride: twister, mechanic: john)
  end

  describe 'when I visit the mechanic show' do
    it 'should display mechanic attributes' do
      visit "/mechanics/#{john.id}"
  
      expect(page).to have_content("#{john.name}")
      expect(page).to have_content("#{john.years_experience}")
    end
  
    it 'should display all the rides the mechanic is worrking on' do
      visit "/mechanics/#{john.id}"
  
      expect(page).to have_content("#{crazy.name}")
      expect(page).to have_content("#{twister.name}")
    end

    it 'should see a form to add a ride to the workload' do
      visit "/mechanics/#{john.id}"

      expect(page).to have_content("Add Ride:")
      expect(page).to have_field(:ride_id)
      expect(page).to have_button("Submit")

      fill_in :ride_id, with: "#{monster.id}"
      click_button "Submit"
  
      expect(current_path).to eq("/mechanics/#{john.id}")
      expect(page).to have_content("Monster")
    end
  end
end