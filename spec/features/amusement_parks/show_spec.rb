require 'rails_helper'

describe 'amusement park show page' do

  before do
    @amusement_park = AmusementPark.create!(name: "Siz Flags Over Texas", admission_cost: 40)
    @mechanic1 = Mechanic.create!(name: 'Charles', years_experience: 1)
    @mechanic2 = Mechanic.create!(name: 'Mary', years_experience: 1)
    @ride1 = Ride.create!(name: 'Texas Titan', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    @ride2 = Ride.create!(name: 'Mr. Freeze', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
    RideMechanic.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)
    RideMechanic.create!(mechanic_id: @mechanic2.id, ride_id: @ride2.id)
  end
  describe 'amusement park details' do
    it 'has its name' do
      expect(page).to have_content("Name: #{@amusement_park.name}")
    end
    it 'has its admission cost' do
      expect(page).to have_content("Admission Cost: #{@amusement_park.admission_cost}")
    end
    it 'has a list of mechanics' do
      expect(page).to have_content(@mechanic1.name)
      expect(page).to have_content(@mechanic2.name)
    end
    it 'that list is of unique mechanics' do
      expect(page).to have_content(@mechanic1.name, count: 1)
    end
  end
end