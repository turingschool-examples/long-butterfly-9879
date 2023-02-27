require 'rails_helper'

RSpec.describe "Show", type: :feature do
  describe "As a visitor" do
    before :each do
      @park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @ride1 = @park.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
      @ride2 = @park.rides.create!(name: "Tower of Doom", thrill_rating: 10, open: true)
      @ride3 = @park.rides.create!(name: "Tea Cups", thrill_rating: 3, open: true)
      @mechanic1 = Mechanic.create!(name: "Kara Smith", years_experience: 11)
      @mechanic2 = Mechanic.create!(name: "Karl Smits", years_experience: 1)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
      visit mechanic_path(@mechanic1.id)
    end
    describe "When I visit the mechanic show page" do
      it "I see their name, years of experience, and the names of all rides they are working on" do
        expect(current_path).to eq(mechanic_path(@mechanic1))
        expect(page).to have_content(@mechanic1.name)
        expect(page).to have_content("Years of Experience: #{@mechanic1.years_experience}")
        expect(page).to have_content("Rides Currently Working On:")
        expect(page).to have_content(@ride1.name)
        expect(page).to have_content(@ride2.name)
        expect(page).to have_no_content(@ride3.name)
        expect(page).to have_no_content(@mechanic2.name)
      end

      it "I see a form to add a ride to their workload. When I fill in that field with an id of an existing ride and click Submit. Im taken back to that mechanic's show page and I see the name of that newly added ride on this mechanic's show page" do
        expect(current_path).to eq(mechanic_path(@mechanic1.id))
        expect(page).to have_no_content(@ride3.name)

        fill_in :ride_id, with: "#{@ride3.id}"
        click_on "Submit"

        expect(page).to have_content(@ride3.name)
      end

      context "when I don't fill out form" do
        it "should see an error message" do
          fill_in :ride_id, with: "9999"
          click_on "Submit"
          
          expect(page).to have_no_content(@ride3.name)
          expect(page).to have_content("")
        end
      end
    end
  end
end