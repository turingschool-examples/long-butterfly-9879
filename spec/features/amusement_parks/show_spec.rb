require 'rails_helper'

RSpec.describe 'amusement parks show page' do
  let!(:amusement_park1) {AmusementPark.create!(name: "Six Flags", admission_cost: 75)}
  let!(:amusement_park2) {AmusementPark.create!(name: "Carowinds", admission_cost: 65)}
  
  let!(:ride1) {Ride.create!(name: "The Hurler", thrill_rating: 7, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride2) {Ride.create!(name: "Tiny Teacups", thrill_rating: 5, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride3) {Ride.create!(name: "Big Slide", thrill_rating: 7, open: false, amusement_park_id: amusement_park2.id )}
  let!(:ride4) {Ride.create!(name: "Danger Drop", thrill_rating: 9, open: false, amusement_park_id: amusement_park1.id )}

  let!(:mechanic1) {Mechanic.create!(name: "Kara Smith", years_experience: 11)}
  let!(:mechanic2) {Mechanic.create!(name: "Michael Scott", years_experience: 1)}
  let!(:mechanic3) {Mechanic.create!(name: "Michael B. Jordan", years_experience: 2)}

  before do
    MechanicRide.create!(ride: ride1, mechanic: mechanic1)
    MechanicRide.create!(ride: ride2, mechanic: mechanic1)
    MechanicRide.create!(ride: ride4, mechanic: mechanic2)
    MechanicRide.create!(ride: ride2, mechanic: mechanic2)
    MechanicRide.create!(ride: ride3, mechanic: mechanic3)

  end

  describe 'as a visitor to the amusement parks show page' do
    it 'I see the name and price of admissions for that park, and see the names of all the mechanics that are working on that parks rides (unique list)' do
      visit "/amusement_parks/#{amusement_park1.id}"

      expect(page).to have_content("Name of Park: Six Flags")
      expect(page).to have_content("Price of admissions: $75")
      expect(page).to have_content("List of all mechanics:")
      expect(page).to have_content("Kara Smith")
      expect(page).to have_content("Michael Scott")

      expect(page).to_not have_content("Michael B. Jordan")

    end
  end
end