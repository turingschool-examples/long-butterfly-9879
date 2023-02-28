require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should belong_to(:ride) }
    it { should belong_to(:mechanic) }
  end

  before do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @kara = Mechanic.create!(name: "Kara Smith", years_experience: 11)

    RideMechanics.create!(ride_id: @hurler.id, mechanic_id: @kara.id)
    RideMechanics.create!(ride_id: @scrambler.id, mechanic_id: @kara.id)
  end
  


end