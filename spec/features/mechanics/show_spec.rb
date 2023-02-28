require 'rails_helper'

RSpec.describe 'Mechanics Show Page', type: :feature do
  let!(:park_1) { AmusementPark.create!(name: 'Six Flags Denver', admission_cost: 30) }
  let!(:ride_1) { park_1.rides.create!(name: 'Twister 2', thrill_rating: 7, open: true) }
  let!(:ride_2) { park_1.rides.create!(name: 'Mind Eraser', thrill_rating: 9, open: true) }
  let!(:ride_3) { park_1.rides.create!(name: 'Tower of Terror', thrill_rating: 8, open: true) }
  let!(:ride_4) { park_1.rides.create!(name: 'Kiddie Coaster', thrill_rating: 3, open: true) }
  let!(:bob) { Mechanic.create!(name: 'Bob Burnquist', years_experience: 5) }
  let!(:tony) { Mechanic.create!(name: 'Tony Hawk', years_experience: 1) }

  before(:each) do
    RideMechanic.create!(ride: ride_1, mechanic: bob)
    RideMechanic.create!(ride: ride_2, mechanic: bob)
    RideMechanic.create!(ride: ride_3, mechanic: bob)
    RideMechanic.create!(ride: ride_4, mechanic: tony)

    visit mechanic_path(bob.id)
  end

  describe 'As a visitor' do
    describe "when I visit the mechanic's show page" do
      it 'I see their name, years of experience, and the names of all rides they are working on' do
        expect(page).to have_content("Name: #{bob.name}")
        expect(page).to have_content("Years of Experience: #{bob.years_experience}")
        expect(page).to have_content("Rides Working On:")

        within 'ul#mechanics_rides' do
          expect(page).to have_content(ride_1.name)
          expect(page).to have_content(ride_2.name)
          expect(page).to have_content(ride_3.name)
          expect(page).to_not have_content(ride_4.name)
          save_and_open_page
        end
      end
    end
  end
end