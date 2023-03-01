require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  before do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11)

    RideMechanics.create!(ride_id: @hurler.id, mechanic_id: @kara.id)
    RideMechanics.create!(ride_id: @scrambler.id, mechanic_id: @kara.id)
  end
  
  describe 'relationships' do
    it { should have_many(:ride_mechanics) }
    it { should have_many(:rides).through(:ride_mechanics) }
  end

  describe '#class_methods' do
    context '#add_to_workload' do
      it 'adds an association between a ride and a mechanic' do
        expect(Mechanic.add_to_workload).to eq()
      end
    end
  end
end