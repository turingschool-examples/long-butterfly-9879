require 'rails_helper'

RSpec.describe 'Mechanic Show Page' do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 50.00)
    @mechanic = Mechanic.create!(name: 'Kara Smith', years_of_experience: 11)
    @ride1 = Ride.create!(name: 'The Frog Hopper', thrill_rating: 2, open: true, amusement_park_id: @six_flags.id)
    @ride2 = Ride.create!(name: 'Fahrenheit', thrill_rating: 5, open: true, amusement_park_id: @six_flags.id)
    @ride3 = Ride.create!(name: 'The Kiss Raise', thrill_rating: 4, open: false, amusement_park_id: @six_flags.id)
    @ride4 = Ride.create!(name: 'Bumper Cars of Doom', thrill_rating: 400, open: true, amusement_park_id: @six_flags.id)
    MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
    MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride2.id)
    MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride3.id)
    visit "/mechanics/#{@mechanic.id}"
  end

  describe 'As a visitor when I visit a mechanics show page' do
    it 'I should see their name, years of experience, and names of all rides they are working on' do
      expect(page).to have_content "Kara Smith"
      expect(page).to have_content "11"
      within "#rides" do
      expect(page).to have_content "Rides they're working on:"
      expect(page).to have_content "The Frog Hopper"
      expect(page).to have_content "Fahrenheit"
      expect(page).to have_content "The Kiss Raise"
      expect(page).to_not have_content "Bumper Cars of Doom"
    end
  end
  
    it 'I should see a form to add a ride to their workload' do
      expect(page).to_not have_content "Bumper Cars of Doom"
      
      fill_in :ride_id, with: @ride4.id
      click_button "Add Ride"
      
      expect(current_path).to eq "/mechanics/#{@mechanic.id}"
      expect(page).to have_content "Bumper Cars of Doom"
    end

  end
end