require 'rails_helper'

RSpec.describe "Mechanics#Show", type: :feature do
  before :each do
    @flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    
    @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11)
    @amos = Mechanic.create!(name: "Amos Burton", years_experience: 20)

    @hurler = @flags.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
    @drop = @flags.rides.create!(name: "The Dungeon Drop", thrill_rating: 8, open: true)
    @splash = @flags.rides.create!(name: "Splash Mountain", thrill_rating: 6, open: true)
    @carousel = @flags.rides.create!(name: "Carousel", thrill_rating: 1, open: true)

    MechanicRide.create!(mechanic_id: @kara.id, ride_id: @hurler.id)
    MechanicRide.create!(mechanic_id: @kara.id, ride_id: @drop.id)
    MechanicRide.create!(mechanic_id: @amos.id, ride_id: @splash.id)
    
    visit "/mechanics/#{@kara.id}"
  end

  describe "User Story 1" do
    context "As a user, when I visit a mechanic show page" do
      it "I see their name, years of experience, and the names of all rides they are working on" do
        
        within("#mechanic_info") do
          expect(page).to have_content("Name: Kara Smith")
          expect(page).to have_content("Years of Experience: 11")
          expect(page).to have_content("The Hurler The Dungeon Drop")
          expect(page).to have_content("The Dungeon Drop")
          expect(page).to_not have_content("Name: Amos Burton")
          expect(page).to_not have_content("Years of Experience: 20")
          expect(page).to_not have_content("Splash Mountain")
        end
      end
    end
  end

  describe "User Story 2" do
    context "As a user, when I visit a mechanic show page" do
      it "I see a form to add a ride to their workload when I fill in that field with an 
        id of an existing ride and click Submit I'm taken back to that mechanic's show page 
        and I see the name of that newly added ride on this mechanic's show page" do
     
        fill_in :ride_id, with: @carousel.id
        click_button "Submit"

        expect(current_path).to eq("/mechanics/#{@kara.id}")
        
        within("#mechanic_info") do
          expect(page).to have_content("Carousel")
        end
      end
    end
  end
end