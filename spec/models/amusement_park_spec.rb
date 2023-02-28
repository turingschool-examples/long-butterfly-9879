require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :admission_cost }
    it { should validate_numericality_of :admission_cost }
  end

  describe '#Instance Methods' do
    before(:each) do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    
      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
    
    end

    describe '#unique_mechanics' do
      it 'returns a list of all mechanics working on rides for amusement park' do
        jim = Mechanic.create!(name: "Jim", years_experience: 10)
        bob = Mechanic.create!(name: "Bob", years_experience: 15)
    
        RideMechanic.create!(ride: @hurler, mechanic: jim)
        RideMechanic.create!(ride: @scrambler, mechanic: bob)

        expect(@six_flags.unique_mechanics).to eq([jim, bob])
      end

      it 'will not return mechanics who are not associated with a ride for the park' do
        adam = Mechanic.create!(name: "Adam", years_experience: 0)

        expect(@six_flags.unique_mechanics).to eq([])
      end

      it 'will only return unique mechanics associated witih a ride for the park' do
        jim = Mechanic.create!(name: "Jim", years_experience: 10)
        bob = Mechanic.create!(name: "Bob", years_experience: 15)
    
        RideMechanic.create!(ride: @hurler, mechanic: jim)
        RideMechanic.create!(ride: @ferris, mechanic: jim)
        RideMechanic.create!(ride: @scrambler, mechanic: bob)

        expect(@six_flags.unique_mechanics).to eq([jim, bob])
      end
    end

    describe '#mechanics_average_experience_by_ride' do
      it 'returns a list of rides associated with the park and average experience of mechanics working on the ride' do
        adam = Mechanic.create!(name: "Adam", years_experience: 0)
        jim = Mechanic.create!(name: "Jim", years_experience: 10)
        bob = Mechanic.create!(name: "Bob", years_experience: 15)
        
        RideMechanic.create!(ride: @scrambler, mechanic: bob)
        RideMechanic.create!(ride: @scrambler, mechanic: adam)
        
        RideMechanic.create!(ride: @hurler, mechanic: jim)
        RideMechanic.create!(ride: @hurler, mechanic: bob)
        
        RideMechanic.create!(ride: @ferris, mechanic: jim)
        RideMechanic.create!(ride: @ferris, mechanic: adam)

        query_result = @six_flags.mechanics_average_experience_by_ride

        expect(query_result).to eq([@hurler, @scrambler, @ferris])
        expect(query_result[0].average_experience).to eq(12.5)
        expect(query_result[1].average_experience).to eq(7.5)
        expect(query_result[2].average_experience).to eq(5)
      end
    end
  end
end