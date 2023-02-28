require 'rails_helper'

RSpec.describe "Amusement Park show page" do 
  describe 'As a visitor' do 
    it 'will have the name and price of admission of the park and a unique list of mechanics working at that park' do
      park = AmusementPark.create!(name: "Six Flags", admission_cost: 10)
      ride1 = park.rides.create!(name: "Tower of doom", thrill_rating: 10, open: true)
      ride2 = park.rides.create!(name: "Splash Mountain", thrill_rating: 10, open: true)
      ride3 = park.rides.create!(name: "Twister", thrill_rating: 10, open: true)
      mechanic = Mechanic.create!(name: "Brian", years_experience: 0)
      mechanic2 = Mechanic.create!(name: "John", years_experience: 4)
      RideMechanic.create!(mechanic: mechanic, ride: ride1)
      RideMechanic.create!(mechanic: mechanic, ride: ride2)
      RideMechanic.create!(mechanic: mechanic2, ride: ride3)

      visit "/amusement_parks/#{park.id}"

      expect(page).to have_content("Park: #{park.name}")
      expect(page).to have_content("Mechanics:")
      expect(page).to have_content(mechanic.name, count: 1)
      expect(page).to have_content(mechanic2.name, count: 1)
    end
  end
end