require 'rails_helper'

RSpec.describe 'Amusement Park Show Page', type: :feature do
  let!(:park_1) { AmusementPark.create!(name: 'Six Flags Denver', admission_cost: 40) }
  let!(:park_2) { AmusementPark.create!(name: 'Lame Ass Park', admission_cost: 20) }
  let!(:ride_1) { park_1.rides.create!(name: 'Twister 2', thrill_rating: 7, open: true) }
  let!(:ride_2) { park_1.rides.create!(name: 'Mind Eraser', thrill_rating: 9, open: true) }
  let!(:ride_3) { park_1.rides.create!(name: 'Tower of Terror', thrill_rating: 8, open: true) }
  let!(:ride_4) { park_1.rides.create!(name: 'Kiddie Coaster', thrill_rating: 3, open: true) }
  let!(:ride_5) { park_1.rides.create!(name: 'Merry Go Round', thrill_rating: 2, open: true) }
  let!(:ride_6) { park_1.rides.create!(name: 'Sheer Terror and Panic', thrill_rating: 10, open: true) }
  let!(:ride_7) { park_2.rides.create!(name: 'Lazy River', thrill_rating: 1, open: true) }
  let!(:bob) { Mechanic.create!(name: 'Bob Burnquist', years_experience: 5) }
  let!(:tony) { Mechanic.create!(name: 'Tony Hawk', years_experience: 1) }
  let!(:steve) { Mechanic.create!(name: 'Steve Caballero', years_experience: 7) }
  let!(:rodney) { Mechanic.create!(name: 'Rodney Mullen', years_experience: 3) }
  let!(:bucky) { Mechanic.create!(name: 'Bucky Lasek', years_experience: 3) }

  before(:each) do
    RideMechanic.create!(ride: ride_1, mechanic: bob)
    RideMechanic.create!(ride: ride_2, mechanic: bob)
    RideMechanic.create!(ride: ride_2, mechanic: steve)
    RideMechanic.create!(ride: ride_3, mechanic: bob)
    RideMechanic.create!(ride: ride_3, mechanic: bucky)
    RideMechanic.create!(ride: ride_4, mechanic: tony)
    RideMechanic.create!(ride: ride_5, mechanic: tony)
    RideMechanic.create!(ride: ride_6, mechanic: bucky)
    RideMechanic.create!(ride: ride_6, mechanic: bob)
    RideMechanic.create!(ride: ride_6, mechanic: steve)
    RideMechanic.create!(ride: ride_7, mechanic: rodney)

    visit amusement_park_path(park_1.id)
  end

  describe 'As a visitor' do
    describe "when I visit an amusement park's show page" do
      it 'Then I see the name and price of admissions for that amusement park' do
        expect(page).to have_content("Park: #{park_1.name}")
        expect(page).to have_content("Price of Admission: $#{park_1.admission_cost}.00")
      end

      it "And I see the names of all mechanics that are working on that park's rides and that the list is unique" do
        expect(page).to have_content("Mechanics on Site:")

        within 'ul#mech_names' do
          expect(page).to have_content(bob.name)
          expect(page).to have_content(tony.name)
          expect(page).to have_content(steve.name)
          expect(page).to_not have_content(rodney.name)
        end
      end

      it "Then I see a list of all of the park's rides" do
        expect(page).to have_content("Park's Rides:")
        
        within 'ul#park_rides' do
          expect(page).to have_content(ride_1.name)
          expect(page).to have_content(ride_2.name)
          expect(page).to have_content(ride_3.name)
          expect(page).to have_content(ride_4.name)
          expect(page).to have_content(ride_5.name)
          expect(page).to have_content(ride_6.name)
        end
      end

      xit " next to each ride I see the average experience of the mechanics working on it, ordered by the most average experience to least" do

      end
    end
  end
end