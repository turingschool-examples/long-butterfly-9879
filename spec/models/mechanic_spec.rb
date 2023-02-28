require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:rides) }
  end

  describe "::unique_mechanics" do
    it "returns only unique mechanics working on rides" do 
  
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
  
      @mechanic_1 = Mechanic.create!(name: "Dawson", years_experience: 5)
      @mechanic_2 = Mechanic.create!(name: "Scott", years_experience: 12)

      @ride_mechanic_1 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic_1.id)
      @ride_mechanic_2 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic_2.id)
      @ride_mechanic_2 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic_2.id)

      expect(@six_flags.mechanics.unique_mechanics).to contain_exactly(@mechanic_2, @mechanic_1)
    end
  end
end