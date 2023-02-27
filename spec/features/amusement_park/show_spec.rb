require 'rails_helper'

RSpec.describe 'Amusement Parks Show Page', type: :feature do
	let!(:six_flags) { AmusementPark.create!(name: 'Six Flags', admission_cost: 75) }
	let!(:disney_world) { AmusementPark.create!(name: 'Disney World', admission_cost: 200) }

	let!(:mechanic_1) { Mechanic.create!(name: 'Mechanic 1.', years_of_experience: 6) }
	let!(:mechanic_2) { Mechanic.create!(name: 'Mechanic 2.', years_of_experience: 6) }
	let!(:mechanic_3) { Mechanic.create!(name: 'Mechanic 3.', years_of_experience: 6) }
	let!(:mechanic_4) { Mechanic.create!(name: 'Mechanic 4.', years_of_experience: 6) }

	let!(:ride_1) { six_flags.rides.create!(name: 'Tea Cups', thrill_rating: 2, open: true) }
	let!(:ride_2) { six_flags.rides.create!(name: 'Merry Go Round', thrill_rating: 2, open: false) }
	let!(:ride_3) { six_flags.rides.create!(name: 'Swings', thrill_rating: 4, open: true) }
	let!(:ride_4) { six_flags.rides.create!(name: 'Haunted House', thrill_rating: 4, open: true) }
	let!(:ride_5) { disney_world.rides.create!(name: 'The Frog Hopper', thrill_rating: 4, open: true) }
	let!(:ride_6) { disney_world.rides.create!(name: 'The Frog Hopper', thrill_rating: 4, open: true) }

	before do
		RideMechanic.create!(mechanic: mechanic_1, ride: ride_1)
		RideMechanic.create!(mechanic: mechanic_2, ride: ride_2)
		RideMechanic.create!(mechanic: mechanic_3, ride: ride_3)
		RideMechanic.create!(mechanic: mechanic_3, ride: ride_5)
		RideMechanic.create!(mechanic: mechanic_4, ride: ride_5)
	end
	
	describe 'displays attributes' do
		it 'has the name of the park and the price of admissions' do
			visit amusement_park_path(six_flags)

			expect(page).to have_content(six_flags.name)
			expect(page).to have_content(six_flags.admission_cost)
		end

		it 'has a unique list of mechanics working on this parks rides' do
			visit amusement_park_path(six_flags)
			
			within '#mechanics' do
				expect(page).to have_content(mechanic_1.name, count: 1)
				expect(page).to have_content(mechanic_2.name, count: 1)
				expect(page).to have_content(mechanic_3.name, count: 1)
				expect(page).to_not have_content(mechanic_4.name)
			end
			
			visit mechanic_path(mechanic_4)

			fill_in :ride_id, with: ride_3.id
			click_button 'Submit'

			visit amusement_park_path(six_flags)
			
			within '#mechanics' do
				expect(page).to have_content(mechanic_4.name, count: 1)
			end
		end
	end
end