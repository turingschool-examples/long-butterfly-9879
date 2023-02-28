require 'rails_helper'

describe 'mechanics show page' do
  before do
    @mechanic = Mechanic.create!(name: 'Charles', years_experience: 1)
    @amusement_park = AmusementPark.create!(name: "Siz Flags Over Texas", admission_cost: 40)
    @ride1 = Ride.create!(name: 'Texas Titan', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    @ride_mechanic = RideMechanic.create!(mechanic_id: @mechanic.id, ride_id: @ride1.id)
    visit mechanic_path(@mechanic)
  end
  describe 'user sees mechanic details' do
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

  describe 'adding a ride form' do
    before do 
      @ride2 = Ride.create!(name: 'Mr. Freeze', thrill_rating: 10, open: true, amusement_park_id: @amusement_park.id)
    end
    it 'has a form to add a ride to the mechanic' do 
      expect(page).to have_field('id')
    end

    it 'when the form is filled, and submitted, the page updates with the new ride' do
      within 'div#rides' do
        expect(page).to_not have_content('Mr. Freeze')
      end
      fill_in 'id', with: @ride2.id
      click_on 'Submit'
      expect(current_path).to eq(mechanic_path(@mechanic))
      within 'div#rides' do
        expect(page).to have_content('Mr. Freeze')
      end
    end

    it 'flashes a message if input is invalid' do
      fill_in 'id', with: 100000000
      click_on 'Submit'
      expect(current_path).to eq(mechanic_path(@mechanic))

      expect(page).to have_content('Invalid id')
    end

  end
end