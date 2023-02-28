require 'rails_helper'

RSpec.describe 'When I visit an amusement park show page', type: :feature do
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
	
	scenario 'I see the name and price of admissions for that amusement park' do
		visit "/amusement_parks/#{@park.id}"
		expect(page).to have_content("Name: #{@park.name}")
		expect(page).to have_content("Admission: $#{@park.admission_cost}")
		expect(page).to_not have_content("Name: #{@park2.name}")
		expect(page).to_not have_content("Admission: #{@park2.admission_cost}")
	end

	scenario 'And I see a unique list of all the names of all mechanics that are working on that parks rides' do
		visit "/amusement_parks/#{@park.id}"
		save_and_open_page
		within '#mechanics' do 
			expect(page).to have_content("Kara Smith")
			expect(page).to have_content("Sam Mills")
			expect(page).to_not have_content("Steve Leftout")
		end		
	end
end