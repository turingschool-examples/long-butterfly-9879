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

    MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_1.id)
    MechanicRide.create!(mechanic_id: @tech_1.id, ride_id: @ride_2.id)
    
    visit "/mechanics/#{@tech_1.id}"
  end

  # User Story 1
  describe "User Story 1" do
    it "shows a mechanics name, years of experience" do
      within("#mechanic_info") do
        expect(page).to have_content("Name: #{@tech_1.name}")
        expect(page).to have_content("Years of Experience: #{@tech_1.years_experience}")
        expect(page).to_not have_content(@tech_2.name)
      end
    end
  
    it "shows the names of all rides they are working on" do
      save_and_open_page
      within("#mechanic_rides") do
        expect(page).to have_content(@ride_1.name)
        expect(page).to have_content(@ride_2.name)
        expect(page).to_not have_content(@ride_3.name)
        expect(page).to_not have_content(@ride_4.name)
      end
    end
  end

  describe "User Story 2" do
    it "has a form where you add an existing ride to this mechanic" do
      within("#add_mechanic_ride") do
        expect(page).to have_field("Ride")
        fill_in("Ride", with: @ride_2.id)
        expect(current_path).to eq("/mechanic/#{@tech_1.id}")
      end

      within("#mechanic_rides") do
        expect(page).to have_content(@ride_3.name)
      end
    end
  end
end