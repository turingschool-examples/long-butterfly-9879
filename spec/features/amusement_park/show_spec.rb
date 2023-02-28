require 'rails_helper'

RSpec.describe "The Amusement Park Show Page" do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)

    @mechanic_1 = Mechanic.create!(name: "Dawson", years_experience: 5)
    @mechanic_2 = Mechanic.create!(name: "Scott", years_experience: 12)

    @ride_mechanic_1 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic_1.id)
    @ride_mechanic_2 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic_2.id)
    @ride_mechanic_2 = RideMechanic.create!(ride_id: @hurler.id, mechanic_id: @mechanic_2.id)

    visit "/amusement_parks/#{@six_flags.id}"
  end
  describe 'User Story 3' do
    it "shows the visitor the name and price of admissions for that amusement park, the names of all mechanics that are working on that park's rides, 
    and a list of mechanics that is unique" do
      expect(page).to have_content('Six Flags')
      expect(page).to have_content('Admission Cost: 75')
      expect(page).to have_content('Dawson')
      expect(page).to have_content('Scott')

      expect(@six_flags.mechanics.unique_mechanics).to contain_exactly(@mechanic_1, @mechanic_2)

      save_and_open_page
    end
  end
end