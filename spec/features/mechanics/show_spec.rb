require 'rails_helper'

RSpec.describe "Mechanic Show Page" do

  let!(:six_flags) { AmusementPark.create!(name: "Six Flags", admission_cost: 75) }
  let!(:knotts) { AmusementPark.create!(name: "Knotts", admission_cost: 65) }
  let!(:kara) { Mechanic.create!(name: "Kara Smith", years_experience: 11) }
  let!(:jen) { Mechanic.create!(name: "Jen Sajevic", years_experience: 8) }
  let!(:hurler) { six_flags.rides.create!(name: "The Hurler", thrill_rating: 7, open: false) }
  let!(:goliath) { knotts.rides.create!(name: "Goliath", thrill_rating: 9, open: true) }

  before do
    MechanicRide.create!(ride: hurler, mechanic: kara)
    MechanicRide.create!(ride: goliath, mechanic: jen)

    visit "/mechanics/#{kara.id}"
  end

  # Story 1
  describe "When I visit /mechanics/:id" do
    it "I see their name, years of experience, and the names of all rides they are working on" do
      expect(page).to have_content("Name: Kara Smith")
      expect(page).to have_content("Experience: 11")
      expect(page).to have_content("Rides: The Hurler")
    end
  end
end
