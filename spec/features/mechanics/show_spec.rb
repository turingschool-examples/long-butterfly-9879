require 'rails_helper'

RSpec.describe "Mechantic show page" do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Park of Amusement", admission_cost: 500)
    @ride_1 = @amusement_park.rides.create!(name: "ride_1", thrill_rating: 2, open: true)
    @ride_2 = @amusement_park.rides.create!(name: "ride_2", thrill_rating: 3, open: true)
    @ride_3 = @amusement_park.rides.create!(name: "ride_3", thrill_rating: 4, open: true)
    @ride_4 = @amusement_park.rides.create!(name: "ride_4", thrill_rating: 5, open: false)
    @mechanic_1 = Mechanic.create!(name: "Guy the mechanic", years_experience: 22)
    @mechanic_2 = Mechanic.create!(name: "Girl the mechanic", years_experience: 33)
    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_1)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_2)
    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_3)
    @mechanic_ride_4 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_4)
  end

  describe "As a user" do
    describe "When I visit a mechantic show page" do
      it "I see their name, years of experience, and the names of all rides they are working on" do
        visit mechanic_path(@mechanic_1)

        expect(page).to have_content(@mechanic_1.name)
        expect(page).to_not have_content(@mechanic_2.name)

        within "#mechanic_details" do
          expect(page).to have_content("Experience: #{@mechanic_1.years_experience}")
          expect(page).to have_content("ride_1 ride_2")
          expect(page).to_not have_content("ride_3 ride_4")
        end
      end
    end
  end
end