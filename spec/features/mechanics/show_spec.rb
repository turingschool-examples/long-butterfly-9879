require 'rails_helper'

describe 'mechanics show page' do

  describe 'user sees mechanic details' do

    before do
      @mechanic = Mechanic.create!(name: 'Charles', years_experience: 1)
      @amusement_park = AmusementPark.create!(name: "Siz Flags Over Texas", admission_cost: 40)
      @ride1 = Ride.create!(name: 'Texas Titan', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
      @ride_mechanic = RideMechanic.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
      visit mechanic_path(@mechanic)
    end
    it 'shows their name' do
      expect(page).to have_content("Name: #{@mechanic.name}")
    end
    it 'shows their years of experience' do
      expect(page).to have_content("YOE: #{@mechanic.years_experience}")
    end
    it 'shows the name of all the rides they are working on' do
      expect(page).to have_content("Rides:")
      expect(page).to have_content("Texas Titan")
    end
  end
end