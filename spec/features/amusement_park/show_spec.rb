require 'rails_helper'

RSpec.describe 'show view' do
  before(:each) do
    @amusement_park = AmusementPark.create!(name: "Six Flags", admission_cost: 100)
    @tower = @amusement_park.rides.create!(name: "Tower of terror", thrill_rating: 7, open: true)
    @spinner = @amusement_park.rides.create!(name: "Spinny Thing", thrill_rating: 7, open: true)
    @twirler = @amusement_park.rides.create!(name: "Twirly Thing", thrill_rating: 10, open: true)
    @coaster = @amusement_park.rides.create!(name: "Rollercoaster", thrill_rating: 1, open: true)
    @steve = Mechanic.create!(name: "Steve", years_experience: 7)
    @bob = Mechanic.create!(name: "Bob", years_experience: 7)
    MechanicRide.create!(ride: @coaster, mechanic: @steve)
    MechanicRide.create!(ride: @tower, mechanic: @steve)
    MechanicRide.create!(ride: @twirler, mechanic: @bob)

    visit "/amusement_parks/#{@amusement_park.id}"
  end
  
  it 'displays a mechanic with their attributes and the names of rides they work on' do
    save_and_open_page
    expect(page).to have_content("Name: #{@amusement_park.name}")
    expect(page).to have_content("Admission cost: #{@amusement_park.admission_cost}")
    expect(page).to have_content("#{@steve.name}")
  end
end