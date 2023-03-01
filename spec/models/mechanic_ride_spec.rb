require 'rails_helper'

RSpec.describe MechanicRide, type: :model do
  describe "class methods" do
    let!(:vidya) { AmusementPark.create!(name: "Vidya Land", admission_cost: 80) }
    let!(:isaac) { Mechanic.create!(name: "Isaac Clarke", years_experience: 13) } 
    let(:dead) { vidya.rides.create!(name: "Dead Space Experience", thrill_rating: 8, open: true) }

    it "#create_new_mechanic_ride" do
      item_params = {
        mechanic_id: isaac.id, 
        ride_id: dead.id
      }
      expect(MechanicRide.create_new_mechanic_ride(item_params)).to eq(isaac.mechanic_rides.last)
    end
  end
end