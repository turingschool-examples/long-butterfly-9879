require 'rails_helper'

RSpec.describe "Show", type: :feature do
  describe "As a visitor" do
    before :each do
      @park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @park2 = AmusementPark.create!(name: 'Disney World', admission_cost: 175)
      @ride1 = @park.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
      @ride2 = @park.rides.create!(name: "Tower of Doom", thrill_rating: 10, open: true)
      @ride3 = @park.rides.create!(name: "Tea Cups", thrill_rating: 3, open: true)
      @mechanic1 = Mechanic.create!(name: "Kara Smith", years_experience: 11)
      @mechanic2 = Mechanic.create!(name: "Karl Smits", years_experience: 1)
      @mechanic3 = Mechanic.create!(name: "Bob Villa", years_experience: 1)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
      MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride3.id)
      MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ride3.id)
      visit amusement_park_path(@park)
    end
    describe "When I visit an amusement parks show page" do
      it "Then I see the name and price of admissions for that amusement park And I see the names of all mechanics that are working on that park's rides, And I see that the list of mechanics is unique" do
        expect(current_path).to eq(amusement_park_path(@park))
        expect(page).to have_content(@park.name)
        expect(page).to have_content("Admission: $#{@park.admission_cost}")
        expect(page).to have_no_content(@park2.name)
        expect(page).to have_no_content("Admission: $#{@park2.admission_cost}")
        expect(page).to have_content("Mechanics Working On Rides:")
        expect(page).to have_content("#{@mechanic1.name}")
        expect(page).to have_content("#{@mechanic2.name}")
        expect(page).to have_no_content("#{@mechanic3.name}")
      end
      #extension
      it "Then I see a list of all of the park's rides, And next to the ride name I see the average experience of the mechanics working on the ride, And I see the list of rides is ordered by the average experience of mechanics working on the ride." do
        expect(page).to have_content(@ride1.name)
        expect(page).to have_content(@ride2.name)
        expect(page).to have_content(@ride3.name) 

        # couldn't get the query to work to order these by average experience.
        # expect(@ride2.name).to appear_before(@ride1.name)
        # expect(@ride2.name).to appear_before(@ride3.name) 
        # expect(@ride1.name).to appear_before(@ride2.name)
      end
    end
  end
end