require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should validate_presence_of :name}
    it { should validate_presence_of :admission_cost }
    it { should validate_numericality_of :admission_cost }
    it { should have_many(:ride_mechanics).through(:rides)}
    it { should have_many(:mechanics).through(:ride_mechanics)}
  end

  describe '#unique_mechanics_names' do
    before do
      @amusement_park = AmusementPark.create!(name: "Siz Flags Over Texas", admission_cost: 40)
      @mechanic1 = Mechanic.create!(name: 'Charles', years_experience: 1)
      @mechanic2 = Mechanic.create!(name: 'Mary', years_experience: 1)
      @ride1 = Ride.create!(name: 'Texas Titan', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
      @ride2 = Ride.create!(name: 'Mr. Freeze', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
      RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
      RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
      RideMechanic.create!(mechanic_id: @mechanic2.id, ride_id: @ride2.id)
    end

    it 'has unique mechanic names' do
      expect(@amusement_park.unique_mechanics_names).to contain_exactly(@mechanic1.name, @mechanic2.name)
    end
  end

  
end