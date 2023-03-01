require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
  end

  let!(:vidya) { AmusementPark.create!(name: "Vidya Land", admission_cost: 80) }
  let!(:bad) { AmusementPark.create!(name: "Bad Land", admission_cost: 10) }

  let!(:isaac) { Mechanic.create!(name: "Isaac Clarke", years_experience: 13) } 
  let!(:chai) { Mechanic.create!(name: "Chai", years_experience: 1) }
  let!(:bart) { Mechanic.create!(name: "Bart", years_experience: 1) }

  let(:dead) { vidya.rides.create!(name: "Dead Space Experience", thrill_rating: 8, open: true) }
  let(:ishimura) { vidya.rides.create!(name: "USG Ishimura", thrill_rating: 10, open: false) }
  let(:hifi) { vidya.rides.create!(name: "Hi-Fi Rush", thrill_rating: 10, open: false) }
  let(:oops) { bad.rides.create!(name: "It Bad", thrill_rating: 1, open: false) }

  describe 'instance methods' do
    it '#unique_mechanics' do
      expect(vidya.unique_mechanics).to eq([isaac, chai])
    end
  end
end