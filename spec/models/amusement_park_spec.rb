require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:mechanic_rides) }
    it { should have_many(:rides).through(:mechanic_rides) }
  end
  before (:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75) 
    @molly = Mechanic.create!(name: "Molly Master Mechanic", years_experience: 25)
    @felix = Mechanic.create!(name: "Felix Fixit", years_experience: 15)
  end
  it 'returns all the unique names of mechanics working on the parks rides' do
    expect(AmusementPark.park_mechanics).to eq([@molly, @felix])
  end
end