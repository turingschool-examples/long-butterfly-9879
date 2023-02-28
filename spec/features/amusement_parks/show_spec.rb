require 'rails_helper'

describe 'as a visitor' do
  describe "When I visit an amusement park's show page" do
    before :each do
      @m1 = Mechanic.create!(name: 'Billy Bob', years_experience: 13)
      @m2 = Mechanic.create!(name: 'Jilly Jane', years_experience: 4)
      @m3 = Mechanic.create!(name: 'Eleven', years_experience: 1)
      @m4 = Mechanic.create!(name: 'Dumbledore', years_experience: 130)

      @p = AmusementPark.create!(name: 'Upside Down Town', admission_cost: 20)
      @r1 = @p.rides.create!(name: 'Vom Bomb', thrill_rating: 7, open: false)
      @r2 = @p.rides.create!(name: 'Bad Hair Day', thrill_rating: 4, open: false)
      @r3 = @p.rides.create!(name: 'SpiderMan', thrill_rating: 6, open: false)
      @r4 = @p.rides.create!(name: 'Demogorgon' , thrill_rating: 9, open: false)
      @r5 = @p.rides.create!(name: 'Tarzan' , thrill_rating: 4, open: false)
      @r6 = @p.rides.create!(name: 'Wingardium Leviosa' , thrill_rating: 10, open: false)


      RideMechanic.create!(ride_id: @r1.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r2.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r3.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r4.id, mechanic_id: @m3.id)
      RideMechanic.create!(ride_id: @r5.id, mechanic_id: @m2.id)
      RideMechanic.create!(ride_id: @r6.id, mechanic_id: @m4.id)


      visit amusement_park_path(@p)
    end
    
    it 'Then I see the name and price of admissions for that amusement park' do
      expect(page).to have_content("Upside Down Town")
      expect(page).to have_content("Admission Price: $20")

    end

    it "I see the names of all mechanics that are working on that park's rides, I see that the list of mechanics is unique" do

      within '#mechanics' do
        expect(page).to have_content("Billy Bob", count: 1 )
        expect(page).to have_content("Jilly Jane", count: 1)
        expect(page).to have_content("Eleven", count: 1)
        expect(page).to have_content("Dumbledore", count: 1)
      end
    end
  end
end