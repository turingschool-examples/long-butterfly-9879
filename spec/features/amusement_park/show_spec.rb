require "rails_helper"

RSpec.describe "AmusementPark#Show" do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Amusement Park", admission_cost: 50)

    @ride_1 = Ride.create!(name: "Ride 1", thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    @ride_2 = Ride.create!(name: "Ride 2", thrill_rating: 5, open: true, amusement_park_id: @amusement_park.id)
    @ride_3 = Ride.create!(name: "Ride 3", thrill_rating: 1, open: true, amusement_park_id: @amusement_park.id)
    @ride_4 = Ride.create!(name: "Ride 4", thrill_rating: 2, open: false, amusement_park_id: @amusement_park.id)

    @tech_1 = Mechanic.create!(name: "Bill", years_experience: 4)
    @tech_2 = Mechanic.create!(name: "Ted", years_experience: 7)

    MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_1.id)
    MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_2.id)
    
    visit "/amusement_park/#{@amusement_park.id}"
  end

  describe "User Story 3" do
    it "shows the name and price of admissions" do

    end

    it "shows the names of all mechanics that are working on that park's rides" do

    end

    it "is a unique list of mechanics" do
      
    end
  end
end