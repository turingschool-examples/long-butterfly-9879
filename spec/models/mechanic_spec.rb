require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should have_many(:ride_mechanics)}
    it { should have_many(:rides).through(:ride_mechanics)}
  end 

  describe 'class_methods' do 
    it 'find_all_mechanics_for_a_park' do 
      park = AmusementPark.create!(name: "Six Flags", admission_cost: 10)
      park2 = AmusementPark.create!(name: "Eight Flags", admission_cost: 10)
      ride1 = park.rides.create!(name: "Tower of doom", thrill_rating: 10, open: true)
      ride2 = park.rides.create!(name: "Splash Mountain", thrill_rating: 10, open: true)
      ride3 = park.rides.create!(name: "Twister", thrill_rating: 10, open: true)
      ride4 = park2.rides.create!(name: "Tornado", thrill_rating: 10, open: true)
      mechanic = Mechanic.create!(name: "Brian", years_experience: 0)
      mechanic2 = Mechanic.create!(name: "John", years_experience: 4)
      mechanic3 = Mechanic.create!(name: "Carolyn", years_experience: 4)
      RideMechanic.create!(mechanic: mechanic, ride: ride1)
      RideMechanic.create!(mechanic: mechanic, ride: ride2)
      RideMechanic.create!(mechanic: mechanic2, ride: ride3)
      RideMechanic.create!(mechanic: mechanic3, ride: ride4)

      expect(Mechanic.find_all_mechanics_for_a_park(park.id)).to eq([mechanic, mechanic2])
      expect(Mechanic.find_all_mechanics_for_a_park(park.id)).to_not include(mechanic3)
    end
  end 
end