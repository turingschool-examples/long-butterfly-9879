require 'rails_helper'

RSpec.describe "Amusement Park Show Page" do

  let!(:six_flags) { AmusementPark.create!(name: "Six Flags", admission_cost: 75) }
  let!(:knotts) { AmusementPark.create!(name: "Knotts", admission_cost: 65) }
  let!(:kara) { Mechanic.create!(name: "Kara Smith", years_experience: 11) }
  let!(:jen) { Mechanic.create!(name: "Jen Sajevic", years_experience: 8) }
  let!(:hurler) { six_flags.rides.create!(name: "The Hurler", thrill_rating: 7, open: false) }
  let!(:goliath) { knotts.rides.create!(name: "Goliath", thrill_rating: 9, open: true) }
  let!(:batman) { six_flags.rides.create!(name: "Batman", thrill_rating: 6, open: false) }
  let!(:twister) { knotts.rides.create!(name: "Twister", thrill_rating: 4, open: true) }

  before do
    MechanicRide.create!(ride: hurler, mechanic: kara)
    MechanicRide.create!(ride: batman, mechanic: kara)
    MechanicRide.create!(ride: goliath, mechanic: jen)
    MechanicRide.create!(ride: twister, mechanic: jen)

    visit "/amusement_park/#{six_flags.id}"
  end

  # Story 3 - Amusement Park Show page
  describe "When I visit /amusement_parks/:id" do
    it "Then I see the name and price of admissions for that amusement park & a unique list of mechanics" do
      expect(page).to have_content("Name: Six Flags")
      expect(page).to have_content("Price: 75")
      expect(page).to have_content("Mechanics: Kara Smith")

      expect(page).to_not have_content("Name: Knotts")
      expect(page).to_not have_content("Price: 65")
      expect(page).to_not have_content("Mechanics: Jen Sajevic")
      # save_and_open_page
    end
  end
end

