require 'rails_helper'

RSpec.describe 'When I visit a mechanic show page', type: :feature do
	before do
		@park = AmusementPark.create!(name: 'Hershey Park', admission_cost: 50)
		@mechanic = Mechanic.create!(name: 'Kara Smith', years_experience: 11)
		@mechanic2 = Mechanic.create!(name: 'Sam Mills', years_experience: 10)
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
	
	scenario 'I see their name, years of experience, and the names of all rides they are working on' do
		visit "/mechanics/#{@mechanic.id}"
		save_and_open_page
		expect(page).to have_content("Name: #{@mechanic.name}")
		expect(page).to have_content("Years of Experience: #{@mechanic.years_experience}")

		within "#rides" do
			expect(page).to have_content("The Frog Hopper")
			expect(page).to have_content("Fahrenheit")
			expect(page).to have_content("Teacups")
			expect(page).to_not have_content("The Boss")
		end
		
		visit "/mechanics/#{@mechanic2.id}"
		expect(page).to have_content("Name: #{@mechanic2.name}")
		expect(page).to have_content("Years of Experience: #{@mechanic2.years_experience}")
		
		within "#rides" do
			expect(page).to have_content("Swings")
			expect(page).to have_content("The Boss")
			expect(page).to_not have_content("The Frog Hopper")
		end
	end
end
		
		