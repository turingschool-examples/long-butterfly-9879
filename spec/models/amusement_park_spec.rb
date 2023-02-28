require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end

	describe 'class methods' do
		before do
			@park = AmusementPark.create!(name: 'Hershey Park', admission_cost: 50)
			@park2 = AmusementPark.create!(name: 'Six Flags', admission_cost: 100)
			@mechanic = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
			@mechanic2 = Mechanic.create!(name: 'Sam Mills', years_experience: 10)
			@mechanic3 = Mechanic.create!(name: 'Steve Leftout', years_experience: 10)
			@coaster = @park.rides.create!(name: 'The Frog Hopper', thrill_rating: 2, open: true)
			@heat = @park.rides.create!(name: 'Fahrenheit', thrill_rating: 5, open: true)
			@teacups = @park.rides.create!(name: 'Teacups', thrill_rating: 1, open: true)
			@swings = @park.rides.create!(name: 'Swings', thrill_rating: 3, open: true)
			@boss = @park.rides.create!(name: 'The Boss', thrill_rating: 4, open: true)
	
			@mechanics_ride1 = MechanicsRide.create!(mechanic: @mechanic, ride: @coaster)
			@mechanics_ride2 = MechanicsRide.create!(mechanic: @mechanic, ride: @heat)
			@mechanics_ride3 = MechanicsRide.create!(mechanic: @mechanic, ride: @teacups)
			@mechanics_ride4 = MechanicsRide.create!(mechanic: @mechanic2, ride: @swings)
			@mechanics_ride5 = MechanicsRide.create!(mechanic: @mechanic2, ride: @boss)
		end

		describe '#uniq_mechanics' do
			it 'returns a list of unique mechanics for the park' do
				expect(@park.uniq_mechanics).to eq([@mechanic, @mechanic2])
			end
		end
	end
end