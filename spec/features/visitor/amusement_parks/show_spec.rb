require 'rails_helper'
RSpec.describe "Visitor Amusement Park Show", type: :feature do 
  let!(:vidya) { AmusementPark.create!(name: "Vidya Land", admission_cost: 80) }
  let!(:bad) { AmusementPark.create!(name: "Bad Land", admission_cost: 10) }

  let!(:isaac) { Mechanic.create!(name: "Isaac Clarke", years_experience: 13) } 
  let!(:chai) { Mechanic.create!(name: "Chai", years_experience: 1) }
  let!(:bart) { Mechanic.create!(name: "Bart", years_experience: 1) }

  let(:dead) { vidya.rides.create!(name: "Dead Space Experience", thrill_rating: 8, open: true) }
  let(:ishimura) { vidya.rides.create!(name: "USG Ishimura", thrill_rating: 10, open: false) }
  let(:hifi) { vidya.rides.create!(name: "Hi-Fi Rush", thrill_rating: 10, open: false) }
  let(:oops) { bad.rides.create!(name: "It Bad", thrill_rating: 1, open: false) }


  describe "As a visitor" do
    context "When I visit the amusement park's show page" do
      before do
        MechanicRide.create!(mechanic: isaac, ride: dead)
        MechanicRide.create!(mechanic: isaac, ride: ishimura)
        MechanicRide.create!(mechanic: chai, ride: hifi)
        MechanicRide.create!(mechanic: chai, ride: dead)
        MechanicRide.create!(mechanic: bart, ride: oops)
        visit visitor_amusement_park_path(vidya)
      end

      it "See the name and prices of admissions for that park" do
        expect(page).to have_content("Vidya Land")
        expect(page).to have_content("#{vidya.name}")
        expect(page).to have_content("80")
        expect(page).to have_content("#{vidya.admission_cost}")
        
        expect(page).to_not have_content("Bad Land")
        expect(page).to_not have_content("#{bad.name}")
        expect(page).to_not have_content("10")
        expect(page).to_not have_content("#{bad.admission_cost}")
      end

      it "I see the names of all unique mechanics (only shown once) that are working on that park's rides" do
        expect(page).to have_content("Isaac Clarke").once
        expect(page).to have_content("#{isaac.name}").once

        expect(page).to have_content("Chai").once
        expect(page).to have_content("#{chai.name}").once
        
        expect(page).to_not have_content("Bart")
        expect(page).to_not have_content("#{bart.name}")
      end
    end
  end
end
