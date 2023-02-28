require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end

  describe "instance method" do

    before do
      @six_flags = AmusementPark.create!(name: "Six Flags", admission_cost: 75) 

      @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11) 
      @ben = Mechanic.create!(name: "Ben Sonder", years_experience: 7) 

      @hurler = @six_flags.rides.create!(name: "The Hurler", thrill_rating: 7, open: false) 
      @batman = @six_flags.rides.create!(name: "Batman", thrill_rating: 6, open: false) 
  
      MechanicRide.create!(ride: @hurler, mechanic: @kara)
      MechanicRide.create!(ride: @batman, mechanic: @ben)
    end 

    it "should have an average mechanic age for specific park" do
      expect(@six_flags.average_experience).to eq(9)
    end
  end
end