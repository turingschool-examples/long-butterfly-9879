require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:rides)}
  end
  
  describe 'instance methods' do
    let!(:wonder) { AmusementPark.create!(name: "WonderWorld", admission_cost: 70)}
    let!(:crazy) { wonder.rides.create!(name: "Crazy", thrill_rating: 5, open: false)}
    let!(:twister) { wonder.rides.create!(name: "Twister", thrill_rating: 7, open: false)}
    let!(:monster) { wonder.rides.create!(name: "Monster", thrill_rating: 7, open: false)}

    let!(:john) {Mechanic.create!(name: "John", years_experience: 10)}
    let!(:smith) {Mechanic.create!(name: "Smith", years_experience: 8)}

    before do
      RideMechanic.create!(ride: crazy, mechanic: john)
      RideMechanic.create!(ride: twister, mechanic: john)
      RideMechanic.create!(ride: monster, mechanic: john) 
  
      RideMechanic.create!(ride: crazy, mechanic: smith) 
      RideMechanic.create!(ride: twister, mechanic: smith) 
    end

    it 'return list of unique mechanics' do
      expect(wonder.list_unqie_mech).to eq([john, smith])
    end
  end

end