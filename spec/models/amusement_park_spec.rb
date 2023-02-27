require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanic_rides).through(:rides) }
    it { should have_many(:mechanics).through(:mechanic_rides) }
  end

  describe "Instance Methods" do
    before :each do
      @flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @disney = AmusementPark.create!(name: 'Disney World', admission_cost: 300)

      @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11)
      @amos = Mechanic.create!(name: "Amos Burton", years_experience: 20)
      @leeroy = Mechanic.create!(name: "Leeroy", years_experience: 2)

  
      @hurler = @flags.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
      @drop = @flags.rides.create!(name: "The Dungeon Drop", thrill_rating: 8, open: true)
      @splash = @flags.rides.create!(name: "Splash Mountain", thrill_rating: 6, open: true)
      @carousel = @disney.rides.create!(name: "Carousel", thrill_rating: 1, open: true)
  
      MechanicRide.create!(mechanic_id: @kara.id, ride_id: @hurler.id)
      MechanicRide.create!(mechanic_id: @kara.id, ride_id: @drop.id)
      MechanicRide.create!(mechanic_id: @amos.id, ride_id: @splash.id)
      MechanicRide.create!(mechanic_id: @leeroy.id, ride_id: @carousel.id)
    end

    describe "#park_mechanics" do
      it "Returns an unique list of mechanics for that park" do
        expect(@flags.park_mechanics).to eq([@kara, @amos])
        expect(@flags.park_mechanics).to_not eq(@leeroy)
      end
    end
  end
end