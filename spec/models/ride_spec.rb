require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many :mechanic_rides}
    it { should have_many :mechanics}
  end

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
    @mechanic_ride_4 = MechanicRide.create!(mechanic_id: @mechanic_2.id, ride_id: @ride_3.id)
  end

  describe '#avg_years_experience' do 
    it 'is the average years of experience of mechanics maintaining the ride' do 
      expect(@ride_1.avg_years_experience).to eq(29.50)
    end
  end
end