require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanic_rides).through(:rides) }
    it { should have_many(:mechanics).through(:mechanic_rides) }
  end

  describe 'instance methods' do
    before(:each) do 
      @jack_mechanic = Mechanic.create!(name: "Jack Frost", years_experience: 12)
      @mary_mechanic = Mechanic.create!(name: "Mary Poppins", years_experience: 25)
      @oliver_mechanic = Mechanic.create!(name: "Oliver Twist", years_experience: 4)
  
      @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)
  
      @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
      @water_world = @universal.rides.create!(name: 'Water World', thrill_rating: 7, open: true)
      @harry_potter = @universal.rides.create!(name: 'Harry Poller & the Forbidden Journey', thrill_rating: 5, open: true)
      @ferris = @universal.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
      @log_flume = @universal.rides.create!(name: 'Log Ride', thrill_rating: 6, open: true)
  
      MechanicRide.create!(mechanic: @jack_mechanic, ride: @ferris)
      MechanicRide.create!(mechanic: @jack_mechanic, ride: @water_world)
      MechanicRide.create!(mechanic: @oliver_mechanic, ride: @log_flume)
    end
  
    it "should return an array of unique mechanics that are working on a ride at that amusement park" do
      expect(@universal.uniq_working_mechanics).to eq([@jack_mechanic, @oliver_mechanic])
      expect(@universal.uniq_working_mechanics).to_not eq([@jack_mechanic, @oliver_mechanic, @mary_mechanic])
    end
  end
end