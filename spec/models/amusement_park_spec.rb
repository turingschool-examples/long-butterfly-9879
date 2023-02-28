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
end