require 'rails_helper'

RSpec.describe "Mechanics Show Page" do 
  before(:each) do 
    @amusement_park = AmusementPark.create!(name: "Fun", admission_cost: 10)

    @ride_1 = @amusement_park.rides.create!(name: "Carousel", thrill_rating: 2, open: true)
    @ride_2 = @amusement_park.rides.create!(name: "Ferris Wheel", thrill_rating: 3, open: true)
    @ride_3 = @amusement_park.rides.create!(name: "Tea Cups", thrill_rating: 5, open: false)
    @ride_4 = @amusement_park.rides.create!(name: "Twister", thrill_rating: 8, open: true)

    @mechanic_1 = Mechanic.create!(name: "Jimothy Dude", years_experience: 14)
    @mechanic_2 = Mechanic.create!(name: "Bob the Builder", years_experience: 45)

    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_1.id)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_2.id)

    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_1.id)
    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_3.id)
  end
  describe 'when visiting the mechanics show page' do 
    it 'has the mechanics name, years of experience and a list of rides they are working on' do 
      visit mechanic_path(@mechanic_1)

      expect(page).to have_content(@mechanic_1.name) 
      expect(page).to_not have_content(@mechanic_2.name)

      within(".mechanic_info") do 
        expect(page).to have_content(@mechanic_1.years_experience)
        expect(page).to have_content("Carousel")
        expect(page).to have_content("Ferris Wheel")
        expect(page).to_not have_content(@mechanic_2.name)
        expect(page).to_not have_content("Twister")
      end
    end
  end
end