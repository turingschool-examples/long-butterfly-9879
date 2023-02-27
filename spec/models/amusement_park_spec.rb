require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanic_rides).through(:rides) }
    it { should have_many(:mechanics).through(:mechanic_rides) }
  end
end