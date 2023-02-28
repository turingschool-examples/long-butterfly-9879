require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  let!(:sixflags) { AmusementPark.create!(name: "Six Flags", admission_cost: 50) }

  let!(:deathcoaster) { sixflags.rides.create!(name: "Death Coaster", thrill_rating: 10, open: true) }
  let!(:freefaller) { sixflags.rides.create!(name: "Free Faller", thrill_rating: 9, open: true) }
  let!(:teacups) { sixflags.rides.create!(name: "Teacups", thrill_rating: 2, open: false) }

  let!(:fred) { Mechanic.create!(name: "Fred", years_experience: 4) }
  let!(:marilyn) { Mechanic.create!(name: "Marilyn", years_experience: 22) }
  let!(:roger) { Mechanic.create!(name: "Roger", years_experience: 6) }
  let!(:jeffrey) { Mechanic.create!(name: "Jeffrey", years_experience: 10) }

  before do
    RideMechanic.create!(ride: deathcoaster, mechanic: fred)
    RideMechanic.create!(ride: deathcoaster, mechanic: marilyn)

    RideMechanic.create!(ride: freefaller, mechanic: fred)
    RideMechanic.create!(ride: freefaller, mechanic: roger)

    RideMechanic.create!(ride: teacups, mechanic: fred)
  end

  describe 'relationships' do
    it { should have_many(:rides) }
  end

  # describe 'Instance Methods' do
  #   it "returns all distinct mechanics for an amusement park" do
  #     expect(sixflags.all_distinct_mechanics).to eq([fred.name, marilyn.name, roger.name])
  #     expect(sixflags.all_distinct_mechanics).to_not include(jeffrey.name)
  #   end
  # end
end