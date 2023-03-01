require 'rails_helper'

RSpec.describe "Mechantic show page" do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Park of Amusement", admission_cost: 500)
    @ride_1 = @amusement_park.rides.create!(name: "ride_1", thrill_rating: 2, open: true)
    @ride_2 = @amusement_park.rides.create!(name: "ride_2", thrill_rating: 3, open: true)
    @ride_3 = @amusement_park.rides.create!(name: "ride_3", thrill_rating: 4, open: true)
    @ride_4 = @amusement_park.rides.create!(name: "ride_4", thrill_rating: 5, open: false)
    @ride_5 = @amusement_park.rides.create!(name: "ride_5", thrill_rating: 6, open: false)
    @mechanic_1 = Mechanic.create!(name: "Guy the mechanic", years_experience: 22)
    @mechanic_2 = Mechanic.create!(name: "Girl the mechanic", years_experience: 33)
    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_1.id)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_2.id)
    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_3.id)
    @mechanic_ride_4 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_4.id)
    @mechanic_ride_5 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_5.id)
  end

  describe "As a user" do
    describe "When I visit a mechantic show page" do
      it "I see their name, years of experience, and the names of all rides they are working on" do
        visit mechanic_path(@mechanic_1)
        save_and_open_page

        expect(page).to have_content(@mechanic_1.name)
        expect(page).to_not have_content(@mechanic_2.name)

        within "#mechanic_details" do
          expect(page).to have_content("Experience: #{@mechanic_1.years_experience} Years")
          expect(page).to have_content("ride_1")
          expect(page).to have_content("ride_2")
          expect(page).to_not have_content("ride_3")
          expect(page).to_not have_content("ride_4")
        end
      end

      describe "I see a form to add a ride to their workload" do
        describe "When I fill in that field with an id of an existing ride and click Submit" do
          describe "Im taken back to that mechanic's show page" do
            it "And I see the name of that newly added ride on this mechanic's show page" do 
              visit mechanic_path(@mechanic_1)

              expect(page).to have_content("Add a ride to #{@mechanic_1.name} workflow")
              
              expect(page).to not_have_content("ride_5")

              within "#add_ride_form" do
                
                fill_in "Ride ID", with: @ride_5.id
                
                click_button("Submit")
                
                expect(current_path).to eq(mechanic_path(@mechanic_1))
              end
              
              expect(page).to have_content("ride_5")
            end
          end
        end
      end
    end
  end
end