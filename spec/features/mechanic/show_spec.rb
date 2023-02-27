require 'rails_helper'

RSpec.describe "Show", type: :feature do
  describe "As a visitor" do
    before :each do
      @park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @ride1 = @park.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
      @ride2 = @park.rides.create!(name: "Tower of Doom", thrill_rating: 10, open: true)
      @ride3 = @park.rides.create!(name: "Tea Cups", thrill_rating: 3, open: true)
      @mechanic1 = Mechanic.create!(name: "Kara Smith", years_experience: 11)
      @mechanic2 = Mechanic.create!(name: "Karl Smits", years_experience: 11)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
      MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
      visit mechanic_path(@mechanic1)
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
    end
  end
end