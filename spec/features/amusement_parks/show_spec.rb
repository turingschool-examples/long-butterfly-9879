require 'rails_helper'

RSpec.describe 'Amusement Park Show Page' do
  before(:each) do 
    @amusement_park_1 = AmusementPark.create!(name: "Disney", admission_cost: 345)
    @mechanic_1 = Mechanic.create!(name: "Hady", years_experience: 9)
    @mechanic_2 = Mechanic.create!(name: "Malena", years_experience: 5)
    @ride1 = @amusement_park_1.rides.create!(name: "Kraken", thrill_rating: 3, open: true)
    @ride2 = @amusement_park_1.rides.create!(name: "Jungle Rush", thrill_rating: 10, open: false)
    @ride3 = @amusement_park_1.rides.create!(name: "Jump High", thrill_rating: 10, open: false)
    MechanicRide.create!(ride_id: @ride1.id, mechanic_id: @mechanic_1.id)
    MechanicRide.create!(ride_id: @ride2.id, mechanic_id: @mechanic_1.id)
    MechanicRide.create!(ride_id: @ride1.id, mechanic_id: @mechanic_2.id)
    MechanicRide.create!(ride_id: @ride3.id, mechanic_id: @mechanic_2.id)

  end

  describe "as a visitor" do
    describe "visit amusement park show page" do 
      it "see the names, price of admission for that amusement park" do 
        visit "/amusement_parks/#{@amusement_park_1.id}"

        expect(page).to have_content("Amusement Park Name: #{@amusement_park_1.name}")
        expect(page).to have_content("Price of Admission: #{@amusement_park_1.admission_cost}")
      end

      it "I see a unique list of mechanics working on that parks' rides" do 
        visit "/amusement_parks/#{@amusement_park_1.id}"

        within("div#mechanics") do 
          expect(page).to have_selector('p', text: @mechanic_1.name, count: 1)
          expect(page).to have_selector('p', text: @mechanic_2.name, count: 1)
        end
      end 

      it "shows a list of all the park's rides" do 
        visit "/amusement_parks/#{@amusement_park_1.id}"

        within("div#park_rides") do 
          expect(page).to have_content("#{@ride2.name} has mechanics with an average experience of 9 years")

          expect(page).to have_content("#{@ride1.name} has mechanics with an average experience of 7 years")

          expect(page).to have_content("#{@ride3.name} has mechanics with an average experience of 5 years")
        end 
      end 
    

    end 
  end 
end 

