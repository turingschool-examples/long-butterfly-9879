require 'rails_helper'

RSpec.describe "AmusementParks#Show", type: :feature do
  before :each do
    @flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @disney = AmusementPark.create!(name: 'Disney World', admission_cost: 300)
    
    @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11)
    @amos = Mechanic.create!(name: "Amos Burton", years_experience: 20)

    @hurler = @flags.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
    @drop = @flags.rides.create!(name: "The Dungeon Drop", thrill_rating: 8, open: true)
    @splash = @flags.rides.create!(name: "Splash Mountain", thrill_rating: 6, open: true)
    @carousel = @flags.rides.create!(name: "Carousel", thrill_rating: 1, open: true)

    MechanicRide.create!(mechanic_id: @kara.id, ride_id: @hurler.id)
    MechanicRide.create!(mechanic_id: @kara.id, ride_id: @drop.id)
    MechanicRide.create!(mechanic_id: @amos.id, ride_id: @splash.id)
    
    visit "/amusement_parks/#{@flags.id}"
  end

  describe "User Story 3" do
    context "As a visitor, I visit an amusement park's show page" do
      it "Then I see the name and price of admissions for that amusement park and I see the names 
        of all mechanics that are working on that park's rides, and I see that the list of mechanics is unique" do
        
        within("#amusement_park_info") do
          expect(page).to have_content("Name: Six Flags")
          expect(page).to have_content("Admission Cost: $75.00")
          expect(page).to_not have_content("Name: Disney World")
          expect(page).to_not have_content("Admission Cost: $300.00")
        end

        within("#mechanics") do
          expect(page).to have_content("Name: Kara Smith").once
          expect(page).to have_content("Name: Amos Burton").once
        end
      end
    end
  end
end