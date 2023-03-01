require 'rails_helper'

RSpec.describe AmusementPark, type: :feature do
  describe 'Amusement show page' do 
    before (:each) do 
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75) 
      @molly = Mechanic.create!(name: "Molly Master Mechanic", years_experience: 25) 
      @mind_eraser = Ride.create!(amusement_park_id: @six_flags.id, name: "Mind Eraser", thrill_rating: 7, open: false) 
      @side_winder = Ride.create!(amusement_park_id: @six_flags.id, name: "Side Winder", thrill_rating: 4, open: true) 
      @heart_stopper = Ride.create!(amusement_park_id: @six_flags.id, name: "Heart Stopper", thrill_rating: 4, open: true) 
      MechanicRide.create!(mechanic_id: @molly.id, ride_id: @mind_eraser.id)
      MechanicRide.create!(mechanic_id: @molly.id, ride_id: @side_winder.id)
      visit "/amusement_parks/#{@six_flags.id}"
    end

    it 'displays the parks name and price of admission' do 
      save_and_open_page
      expect(page).to have_content("Six Flags")
      expect(page).to have_content("Admission Price: $75.00")
    end
  end
end