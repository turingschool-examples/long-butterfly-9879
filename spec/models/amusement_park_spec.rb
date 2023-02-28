require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  let!(:amusement_park1) {AmusementPark.create!(name: "Six Flags", admission_cost: 75)}
  
  let!(:ride1) {Ride.create!(name: "The Hurler", thrill_rating: 7, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride2) {Ride.create!(name: "Tiny Teacups", thrill_rating: 5, open: false, amusement_park_id: amusement_park1.id )}
  let!(:ride4) {Ride.create!(name: "Danger Drop", thrill_rating: 9, open: false, amusement_park_id: amusement_park1.id )}

  let!(:mechanic1) {Mechanic.create!(name: "Kara Smith", years_experience: 11)}
  let!(:mechanic2) {Mechanic.create!(name: "Michael Scott", years_experience: 1)}
  let!(:mechanic3) {Mechanic.create!(name: "Michael B. Jordan", years_experience: 2)}

  before do
    MechanicRide.create!(ride: ride1, mechanic: mechanic1)
    MechanicRide.create!(ride: ride2, mechanic: mechanic1)
    MechanicRide.create!(ride: ride4, mechanic: mechanic2)
    MechanicRide.create!(ride: ride2, mechanic: mechanic2)
  end

  describe 'relationships' do
    it { should have_many :rides }
  end

  describe 'instance methods' do
    xit '#list_of_mechanics' do
      expect(amusement_park1.list_of_mechanics).to eq([mechanic1.name, mechanic2.name])
    end
  end
end