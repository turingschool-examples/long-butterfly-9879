require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:ride_mechanics).through(:rides) }
    it { should have_many(:mechanics).through(:ride_mechanics) }
  end

  let!(:park_1) { AmusementPark.create!(name: 'Six Flags Denver', admission_cost: 40) }
  let!(:park_2) { AmusementPark.create!(name: 'Lame Ass Park', admission_cost: 20) }
  let!(:ride_1) { park_1.rides.create!(name: 'Twister 2', thrill_rating: 7, open: true) }
  let!(:ride_2) { park_1.rides.create!(name: 'Mind Eraser', thrill_rating: 9, open: true) }
  let!(:ride_3) { park_1.rides.create!(name: 'Tower of Terror', thrill_rating: 8, open: true) }
  let!(:ride_4) { park_1.rides.create!(name: 'Kiddie Coaster', thrill_rating: 3, open: true) }
  let!(:ride_5) { park_1.rides.create!(name: 'Merry Go Round', thrill_rating: 2, open: true) }
  let!(:ride_6) { park_1.rides.create!(name: 'Sheer Terror and Panic', thrill_rating: 10, open: true) }
  let!(:ride_7) { park_2.rides.create!(name: 'Lazy River', thrill_rating: 1, open: true) }
  let!(:bob) { Mechanic.create!(name: 'Bob Burnquist', years_experience: 5) }
  let!(:tony) { Mechanic.create!(name: 'Tony Hawk', years_experience: 1) }
  let!(:steve) { Mechanic.create!(name: 'Steve Caballero', years_experience: 7) }
  let!(:rodney) { Mechanic.create!(name: 'Rodney Mullen', years_experience: 3) }
  let!(:bucky) { Mechanic.create!(name: 'Bucky Lasek', years_experience: 3) }

  before(:each) do
    RideMechanic.create!(ride: ride_1, mechanic: bob)
    RideMechanic.create!(ride: ride_2, mechanic: bob)
    RideMechanic.create!(ride: ride_3, mechanic: bob)
    RideMechanic.create!(ride: ride_4, mechanic: tony)
    RideMechanic.create!(ride: ride_5, mechanic: tony)
    RideMechanic.create!(ride: ride_6, mechanic: steve)
    RideMechanic.create!(ride: ride_2, mechanic: steve)
    RideMechanic.create!(ride: ride_7, mechanic: rodney)
  end

  describe '#instance_methods' do
    it '#mechanic_names' do
      expect(park_1.mechanic_names).to eq([bob.name, steve.name, tony.name])
      expect(park_1.mechanic_names).to_not eq([bob.name, bob.name, bob.name, steve.name, steve.name, steve.name, steve.name])
      expect(park_1.mechanic_names).to_not eq([bob.name, steve.name, tony.name, rodney.name])
      expect(park_2.mechanic_names).to eq([rodney.name])

      RideMechanic.create!(ride: ride_7, mechanic: bucky)
      
      expect(park_2.mechanic_names).to eq([bucky.name, rodney.name])
    end
  end
end