require 'rails_helper'

RSpec.describe "Amusement Parks Show Page" do 
  before(:each) do 
    @amusement_park = AmusementPark.create!(name: "Fun", admission_cost: 10)

    @ride_1 = @amusement_park.rides.create!(name: "Carousel", thrill_rating: 2, open: true)
    @ride_2 = @amusement_park.rides.create!(name: "Ferris Wheel", thrill_rating: 3, open: true)
    @ride_3 = @amusement_park.rides.create!(name: "Tea Cups", thrill_rating: 5, open: false)
    @ride_4 = @amusement_park.rides.create!(name: "Twister", thrill_rating: 8, open: true)

    @mechanic_1 = Mechanic.create!(name: "Jimothy Dude", years_experience: 14)
    @mechanic_2 = Mechanic.create!(name: "Bob the Builder", years_experience: 45)
    @mechanic_3 = Mechanic.create!(name: "Clyde", years_experience: 1) 

    @mechanic_ride_1 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_1.id)
    @mechanic_ride_2 = MechanicRide.create!(mechanic_id: @mechanic_1.id, ride_id: @ride_2.id)

    @mechanic_ride_3 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_1.id)
    @mechanic_ride_4 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_3.id)
    @mechanic_ride_5 = MechanicRide.create!(mechanic_id: @mechanic_3.id, ride_id: @ride_4.id)
  end

  describe 'when visiting an amusement parks show page' do 
    it 'has the name and price of admissions for that park' do 
      visit amusement_park_path(@amusement_park)

      expect(page).to have_content("Fun")

      within(".park_info") do 
        expect(page).to have_content("Admission Cost: $10")
      end
    end
    it 'has a list of unique names of all mechanics that are working on that parks rides' do 
      visit amusement_park_path(@amusement_park)

      within(".mechanics_at_park") do 
        expect(page).to have_content("Jimothy Dude", count: 1)
        expect(page).to have_content("Bob the Builder", count: 1)
      end
    end
  end

  describe 'extension' do 
    it ' has a list of all the parks rides' do 
      visit amusement_park_path(@amusement_park) 

      within(".park_rides") do 
        expect(page).to have_content(@ride_1.name)
        expect(page).to have_content(@ride_2.name)
        expect(page).to have_content(@ride_3.name)
        expect(page).to have_content(@ride_4.name)
      end
    end

    it 'has mechanics average years of experience for that ride' do 
      visit amusement_park_path(@amusement_park) 

      within("#ride_#{@ride_1.id}") do 
        expect(page).to have_content("Mechanic Years of Experience: 29.50")
      end

      within("#ride_#{@ride_2.id}") do 
        expect(page).to have_content("Mechanic Years of Experience: 14.00")
      end

      within("#ride_#{@ride_3.id}") do 
        expect(page).to have_content("Mechanic Years of Experience: 45.00")
      end

      within("#ride_#{@ride_4.id}") do 
        expect(page).to have_content("Mechanic Years of Experience: 1.00")
      end
    end

    it 'orders the rides by years of experience of mechanic' do 
      visit amusement_park_path(@amusement_park) 

      within(".park_rides") do 
       expect(@ride_3.name).to appear_before(@ride_1.name)
       expect(@ride_1.name).to appear_before(@ride_2.name)
       expect(@ride_2.name).to appear_before(@ride_4.name)
      end
    end
  end
end