require 'rails_helper'
RSpec.describe "Mechanics Show", type: :feature do 
  let!(:vidya) { AmusementPark.create!(name: "Vidya Land", admission_cost: 80) }

  let!(:isaac) { Mechanic.create!(name: "Isaac Clarke", years_experience: 13) } 
  let!(:chai) { Mechanic.create!(name: "Chai", years_experience: 1) }

  let(:dead) { vidya.rides.create!(name: "Dead Space Experience", thrill_rating: 8, open: true) }
  let(:ishimura) { vidya.rides.create!(name: "USG Ishimura", thrill_rating: 10, open: false) }
  let(:hifi) { vidya.rides.create!(name: "Hi-Fi Rush", thrill_rating: 10, open: false) }


  describe "As a user" do
    context "When I visit a mechanics show page" do
      before do
        MechanicRide.create!(mechanic: isaac, ride: dead)
        MechanicRide.create!(mechanic: isaac, ride: ishimura)
        MechanicRide.create!(mechanic: chai, ride: hifi)
        MechanicRide.create!(mechanic: chai, ride: dead)
        visit mechanic_path(isaac)
      end

      it "See the name, years of experience, and name of all rides they are working on" do
        save_and_open_page
        expect(page).to have_content("Isaac Clarke")
        expect(page).to have_content("#{isaac.name}")

        expect(page).to have_content("13")
        expect(page).to have_content("#{isaac.years_experience}")

        expect(page).to have_content("Dead Space Experience")
        expect(page).to have_content("#{dead.name}")

        expect(page).to have_content("USG Ishimura")
        expect(page).to have_content("#{ishimura.name}")

        expect(page).to_not have_content("Chai")
        expect(page).to_not have_content("#{chai.name}")
        expect(page).to_not have_content("Hi-Fi Rush")
        expect(page).to_not have_content("#{hifi.name}")
      end


    end
  end
end
