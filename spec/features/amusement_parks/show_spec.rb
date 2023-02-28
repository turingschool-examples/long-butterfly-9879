require 'rails_helper'

RSpec.describe 'Amusement Park Show Page' do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 50)
    @mechanic = Mechanic.create!(name: 'Kara Smith', years_of_experience: 11)
    @mechanic2 = Mechanic.create!(name: 'Crusty Old Guy', years_of_experience: 7)
    @mechanic3 = Mechanic.create!(name: 'Overly Eager New Guy', years_of_experience: 1)
    @ride1 = Ride.create!(name: 'The Frog Hopper', thrill_rating: 2, open: true, amusement_park_id: @six_flags.id)
    @ride2 = Ride.create!(name: 'Fahrenheit', thrill_rating: 5, open: true, amusement_park_id: @six_flags.id)
    @ride3 = Ride.create!(name: 'The Kiss Raise', thrill_rating: 4, open: false, amusement_park_id: @six_flags.id)
    @ride4 = Ride.create!(name: 'Bumper Cars of Doom', thrill_rating: 400, open: true, amusement_park_id: @six_flags.id)
    MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
    MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride2.id)
    MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride3.id)
    MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride2.id)
    MechanicRide.create!(mechanic_id: @mechanic3.id, ride_id: @ride2.id)
    visit "/amusement_parks/#{@six_flags.id}"
  end

  describe 'As a visitor when I visit an amusement parks show page' do
    it 'I should see the name and price of admissions for that amusement park' do
      expect(page).to have_content "Six Flags"
      expect(page).to have_content "Admission Cost: $50"
    end

    it 'I should see the names of all mechanics that work are working on rides at the park' do
      within "#mechanics" do
        expect(page).to have_content "Mechanics working at Six Flags:"
        expect(page).to have_content("Kara Smith").once
        expect(page).to have_content("Crusty Old Guy").once
        expect(page).to have_content("Overly Eager New Guy").once
      end
    end

    xit 'I should see a list of all rides and the average years of experience for the mechanics working on that ride' do
      within "#rides" do
        expect(page).to have_content "Rides at Six Flags:"
        expect(page).to have_content "The Frog Hopper -- AVG Years of Experience: 11"
        expect(page).to have_content "Fahrenheit -- AVG Years of Experience: 9"
        expect(page).to have_content "The Kiss Raise -- AVG Years of Experience: 7"
        expect(page).to have_content "Bumper Cars of Doom -- AVG Years of Experience: 0"
      end
    end
  end
end