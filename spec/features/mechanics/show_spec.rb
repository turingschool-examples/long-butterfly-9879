require 'rails_helper'

RSpec.describe 'mechanics show page' do
  let!(:amusement_park1) {AmusementPark.create!(name: "Six Flags", admission_cost: 75)}
  let!(:ride1) {Ride.create!(name: "The Hurler", thrill_rating: 7, open: false, amusement_park_id: amusement_park1.id )}
  let!(:mechanic1) {Mechanic.create!(name: "Kara Smith", years_experience: 11)}
  
  describe 'as a visitor' do
    it 'shows their name, years of experience and the names of all the rides they are working on' do
      visit "/mechanics/#{mechanic1.id}"

      expect(page).to have_content("Name: Kara Smith")
      expect(page).to have_content("Years of Experience: 11")
      expect(page).to have_content("Rides working on:")

    end
  end
end