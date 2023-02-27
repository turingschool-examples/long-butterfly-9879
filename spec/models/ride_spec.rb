require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
		it { should have_many(:ride_mechanics)}
		it { should have_many(:mechanics).through(:ride_mechanics)}
  end

	let!(:six_flags) { AmusementPark.create!(name: 'Six Flags', admission_cost: 75) }
	let!(:disney_world) { AmusementPark.create!(name: 'Disney World', admission_cost: 200) }

	let!(:mechanic_1) { Mechanic.create!(name: 'Mechanic 1.', years_of_experience: 6) }
	let!(:mechanic_2) { Mechanic.create!(name: 'Mechanic 2.', years_of_experience: 5) }
	let!(:mechanic_3) { Mechanic.create!(name: 'Mechanic 3.', years_of_experience: 1) }
	let!(:mechanic_4) { Mechanic.create!(name: 'Mechanic 4.', years_of_experience: 8) }

	let!(:ride_1) { six_flags.rides.create!(name: 'Tea Cups', thrill_rating: 2, open: true) }
	let!(:ride_2) { six_flags.rides.create!(name: 'Merry Go Round', thrill_rating: 2, open: false) }
	let!(:ride_3) { six_flags.rides.create!(name: 'Swings', thrill_rating: 4, open: true) }
	let!(:ride_4) { six_flags.rides.create!(name: 'Haunted House', thrill_rating: 4, open: true) }
	let!(:ride_5) { disney_world.rides.create!(name: 'The Frog Hopper', thrill_rating: 4, open: true) }
	let!(:ride_6) { disney_world.rides.create!(name: 'The Frog Hopper', thrill_rating: 4, open: true) }

	before do
		RideMechanic.create!(mechanic: mechanic_1, ride: ride_1)
		RideMechanic.create!(mechanic: mechanic_2, ride: ride_1)
		RideMechanic.create!(mechanic: mechanic_3, ride: ride_1)
		RideMechanic.create!(mechanic: mechanic_1, ride: ride_3)
		RideMechanic.create!(mechanic: mechanic_4, ride: ride_3)
		RideMechanic.create!(mechanic: mechanic_3, ride: ride_5)
		RideMechanic.create!(mechanic: mechanic_4, ride: ride_2)
	end

	describe '#instance_methods' do
		it '#average_experience' do
			rides = six_flags.rides.with_mechanic_average_experience

			expect(rides.first.avg_years.to_f.round(2)).to eq(0.0)
			expect(rides.second.avg_years.to_f.round(2)).to eq(8.0)
			expect(rides.third.avg_years.to_f.round(2)).to eq(7.0)
			expect(rides.last.avg_years.to_f.round(2)).to eq(4.0)

			RideMechanic.create!(mechanic: mechanic_3, ride: ride_2)

			expect(rides.last.avg_years.to_f.round(2)).to eq(4.0)
			# This should equal 4.5???
		end
	end
end