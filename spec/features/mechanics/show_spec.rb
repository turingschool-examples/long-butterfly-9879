require 'rails_helper'

RSpec.describe 'mechanics show page' do
  let!(:amusement_park1) {AmusementPark.create!(name: "Six Flags", admission_cost: 75)}
  let!(:ride1) {Ride.create!(name: "The Hurler", thrill_rating: 7, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride2) {Ride.create!(name: "Tiny Teacups", thrill_rating: 5, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride3) {Ride.create!(name: "Big Slide", thrill_rating: 7, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride4) {Ride.create!(name: "Danger Drop", thrill_rating: 9, open: false, amusement_park_id: amusement_park1.id )}

  let!(:mechanic1) {Mechanic.create!(name: "Kara Smith", years_experience: 11)}
  let!(:mechanic2) {Mechanic.create!(name: "Michael Scott", years_experience: 1)}


  before do
    MechanicRide.create!(ride: ride1, mechanic: mechanic1)
    MechanicRide.create!(ride: ride2, mechanic: mechanic1)
    MechanicRide.create!(ride: ride3, mechanic: mechanic2)

  end
  
  describe 'as a visitor' do
    it 'shows their name, years of experience and the names of all the rides they are working on' do
      visit "/mechanics/#{mechanic1.id}"

      expect(page).to have_content("Name: Kara Smith")
      expect(page).to have_content("Years of Experience: 11")
      expect(page).to have_content("Rides working on:")
      expect(page).to have_content("The Hurler")
      expect(page).to have_content("Tiny Teacups")

      expect(page).to_not have_content("Michael Scott")
      expect(page).to_not have_content("Big Slide")

    end
    it 'shows a form to add a ride to their workload' do
      visit "/mechanics/#{mechanic1.id}"

      expect(page).to have_field(:ride_id)
      expect(page).to have_button("Submit")
      expect(page).to have_content("Add a ride to workload")

    end

    it 'when I fill in field with id of a ride and click submit, I am taken back to the mechanics show page and see the name of that newly added ride' do
      visit "/mechanics/#{mechanic1.id}"

      fill_in :ride_id, with: "#{ride4.id}"
      click_on "Submit"

      expect(current_path).to eq("/mechanics/#{mechanic1.id}")
      expect(page).to have_content("Danger Drop")
    end
  end
end