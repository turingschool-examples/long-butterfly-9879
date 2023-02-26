require 'rails_helper'

RSpec.describe 'Mechanic Show Page' do
  before(:each) do 
    @amusement_park_1 = AmusementPark.create!(name: "Disney", admission_cost: 345)
    @mechanic_1 = Mechanic.create!(name: "Hady", years_experience: 5)
    @ride1 = @amusement_park_1.rides.create!(name: "Kraken", thrill_rating: 3, open: true)
    @ride2 = @amusement_park_1.rides.create!(name: "Jungle Rush", thrill_rating: 10, open: false)
    @ride3 = @amusement_park_1.rides.create!(name: "Jump High", thrill_rating: 10, open: false)
    MechanicRide.create!(ride_id: @ride1.id, mechanic_id: @mechanic_1.id)
    MechanicRide.create!(ride_id: @ride2.id, mechanic_id: @mechanic_1.id)


  end 

  describe "as a visitor" do
    describe "visit mechanic show page" do 
      it "see the names, years of experience, and names of rides they're working on" do 
        visit "/mechanics/#{@mechanic_1.id}"

        expect(page).to have_content("Mechanic Name: #{@mechanic_1.name}")
        expect(page).to have_content("Mechanic Years of Experience: #{@mechanic_1.years_experience}")

        within("div#rides_working_on") do 
          expect(page).to have_content("#{@ride1.name}")
          expect(page).to have_content("#{@ride2.name}")
        end 
      end

      it "has a form to add a ride to their workload" do 
        visit "/mechanics/#{@mechanic_1.id}"

        expect(page).to have_selector('form')
        expect(page).to have_field(:ride_id)
        expect(page).to have_button("Add Ride")

      end

      it "fill in form with id of existing ride and click submit, am taken back to mechanic show page and see the new ride on the page" do
        visit "/mechanics/#{@mechanic_1.id}"

        expect(page).to_not have_content("#{@ride3.name}")

        fill_in "ride_id", with: @ride3.id
        click_button("Add Ride")

        expect(current_path).to eq("/mechanics/#{@mechanic_1.id}")
        expect(page).to have_content("#{@ride3.name}")

      end 





    end
  end
end 