require 'rails_helper'

RSpec.describe '/amusment_parks/:id', type: :feature do
  before(:each) do 
    @jack_mechanic = Mechanic.create!(name: "Jack Frost", years_experience: 12)
    @mary_mechanic = Mechanic.create!(name: "Mary Poppins", years_experience: 25)
    @oliver_mechanic = Mechanic.create!(name: "Oliver Twist", years_experience: 4)

    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
    @water_world = @universal.rides.create!(name: 'Water World', thrill_rating: 7, open: true)
    @harry_potter = @universal.rides.create!(name: 'Harry Poller & the Forbidden Journey', thrill_rating: 5, open: true)
    @ferris = @universal.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    @log_flume = @universal.rides.create!(name: 'Log Ride', thrill_rating: 6, open: true)

    MechanicRide.create!(mechanic: @jack_mechanic, ride: @ferris)
    MechanicRide.create!(mechanic: @jack_mechanic, ride: @water_world)
    MechanicRide.create!(mechanic: @oliver_mechanic, ride: @log_flume)
  end
  
  describe "As a visitor, when I visit an amusement park's show page" do
    # User Story 3
    it "I see the name and price of admissions for that amusement park" do
      visit "/amusement_parks/#{@universal.id}"

      expect(page).to have_content("Welcome to #{@universal.name}")
      expect(page).to have_content("Price of Admission: $#{@universal.admission_cost}.00")
    end

    # User Story 3
    it "I also see the UNIQUE names of all mechanics that are working on that park's rides" do
      visit "/amusement_parks/#{@universal.id}"

      within "#now_working" do
        expect(page).to have_content("Currently Working Mechanics:")
        expect(page).to have_content("#{@jack_mechanic.name}")
        expect(page).to have_content("#{@oliver_mechanic.name}")
        
        expect(page).to_not have_content("#{@mary_mechanic.name}")
      end
    end
  end
end
