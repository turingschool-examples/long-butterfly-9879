require 'rails_helper'

RSpec.describe 'the mechanic show page' do
  describe 'as a user' do
    describe 'when I visit the mechanic show page' do
      it 'I see their name, years of experience, and the names of all rides they are working on' do
        elitch = AmusementPark.create!(name: "Elitch Gardens", admission_cost: 50)

        coaster = Ride.create!(name: 'Zoom', thrill_rating: 8, open: true, amusement_park: elitch)
        wheel = Ride.create!(name: 'Wheel of danger', thrill_rating: 6, open: false, amusement_park: elitch)
        slide = Ride.create!(name: 'Slide', thrill_rating: 4, open: true, amusement_park: elitch)

        mechanic_1 = Mechanic.create!(name: 'Matt Smith', years_experience: 2)

        ride_mech_1 = RideMechanic.create(ride: coaster, mechanic: mechanic_1)
        ride_mech_2 = RideMechanic.create(ride: wheel, mechanic: mechanic_1)

        visit "mechanics/#{mechanic_1.id}"
        save_and_open_page
        expect(page).to have_content("Name: #{mechanic_1.name}")
        expect(page).to have_content("Years Experience: #{mechanic_1.years_experience}")
        expect(page).to have_content("#{coaster.name}")
        expect(page).to have_content("#{wheel.name}")
        expect(page).to_not have_content("#{slide.name}")

      end
    end
  end
end