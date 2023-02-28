require 'rails_helper'

describe 'As a user' do
  describe 'when i visit a mechanic show page' do

    before :each do
      @m1 = Mechanic.create!(name: 'Billy Bob', years_experience: 13)
      @p = AmusementPark.create!(name: 'Upside Down Town', admission_cost: 20)
      @r1 = @p.rides.create!(name: 'Vom Bomb', thrill_rating: 7, open: false)
      @r2 = @p.rides.create!(name: 'Bad Hair Day', thrill_rating: 4, open: false)
      @r3 = @p.rides.create!(name: 'SpiderMan', thrill_rating: 6, open: false)

      RideMechanic.create!(ride_id: @r1.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r2.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r3.id, mechanic_id: @m1.id)
    end

    it 'I see their name, years of experience, and the names of all rides they are working on' do
      visit mechanic_path(@m1)

      expect(page).to have_content('Billy Bob')
      expect(page).to have_content('Years of Experience: 13')

      within('#rides') do
        expect(page).to have_content('Vom Bomb')
        expect(page).to have_content('Bad Hair Day')
        expect(page).to have_content('SpiderMan')
      end 
    end
  end
end