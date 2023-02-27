require 'rails_helper'

RSpec.describe 'Mechanics Show Page', type: :feature do
	let!(:mechanic) { Mechanic.create!(name: 'Mechanic M.', years_of_experience: 6) }

	let!(:amusement_park) { AmusementPark.create!(name: 'Six Flags', admission_cost: 75) }
	let!(:ride_1) { amusement_park.rides.create!(name: 'Tea Cups', thrill_rating: 2, open: true) }
	let!(:ride_2) { amusement_park.rides.create!(name: 'Merry Go Round', thrill_rating: 2, open: false) }
	let!(:ride_3) { amusement_park.rides.create!(name: 'Swings', thrill_rating: 4, open: true) }

	before do
		RideMechanic.create!(mechanic: mechanic, ride: ride_1)
		RideMechanic.create!(mechanic: mechanic, ride: ride_2)
		RideMechanic.create!(mechanic: mechanic, ride: ride_3)
	end

	describe 'mechanic attributes' do
		it 'displays the name, years of experience and the rides they are working on' do
			visit mechanic_path(mechanic)

			expect(page).to have_content(mechanic.name)
			expect(page).to have_content("Years of Experience: 6")

			within '#mechanic-rides' do
				expect(page).to have_content(ride_1.name)
				expect(page).to have_content(ride_2.name)
				expect(page).to have_content(ride_3.name)
			end
		end
	end
end