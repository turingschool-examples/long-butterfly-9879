require "rails_helper"

RSpec.describe "Mechanic#Show" do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Amusement Park", admission_cost: 50)

    @ride_1 = Ride.create!(name: "Ride 1", thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    @ride_2 = Ride.create!(name: "Ride 2", thrill_rating: 5, open: true, amusement_park_id: @amusement_park.id)
    @ride_3 = Ride.create!(name: "Ride 3", thrill_rating: 1, open: true, amusement_park_id: @amusement_park.id)
    @ride_4 = Ride.create!(name: "Ride 4", thrill_rating: 2, open: false, amusement_park_id: @amusement_park.id)

    @tech_1 = Mechanic.create!(name: "Bill", years_experience: 4)
    @tech_2 = Mechanic.create!(name: "Ted", years_experience: 7)
    
    visit "/mechanics/#{@tech_1.id}"
  end

  it "shows a mechanics name, years of experience" do
    within("#mechanic_info") do
      expect(page).to have_content(@tech_1.name)
      expect(page).to have_content(@tech_1.years_experience)
    end
  end

  it "shows the names of all rides they are working on" do

  end
end