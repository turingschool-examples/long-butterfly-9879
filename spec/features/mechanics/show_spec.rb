require 'rails_helper'

RSpec.describe "Mechanics#Show", type: :feature do
  before do
    @flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    
    @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11)
    @amos = Mechanic.create!(name: "Amos Burton", years_experience: 20)

    @hurler = @kara.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
    @drop = @kara.rides.create!(name: "The Dungeon Drop", thrill_rating: 8, open: true)
    @hurler = @amos.rides.create!(name: "Splash Mountain", thrill_rating: 6, open: true)
  end

  describe "User Story 1" do
    context "As a user, when I visit a mechanic show page" do
      it "I see their name, years of experience, and the names of all rides they are working on" do
        visit "/mechanics/#{@kara.id}"
        
        expect(page).to have_content("Name: Kara Smith")
        expect(page).to have_content("Years of Experience: 11")
        expect(page).to have_content("Rides Currently Working on: The Hurler, The Dungeon Drop")
        expect(page).to_not have_content("Name: Amos Burton")
        expect(page).to_not have_content("Years of Experience: 20")
        expect(page).to_not have_content("Rides Currently Working on: Splash Mountain")
      end
    end
  end
end