require 'rails_helper'

RSpec.describe 'show view' do
  
  
  it 'displays a mechanic with their attributes and the names of rides they work on' do
    @amusement_park = AmusementPark.create!(name: "Six Flags", admission_cost: 100)
    @tower = @amusement_park.rides.create!(name: "Tower of terror", thrill_rating: 7, open: true)
    @coaster = @amusement_park.rides.create!(name: "Rollercoaster", thrill_rating: 1, open: true)
    @steve = Mechanic.create!(name: "Steve", years_experience: 7)
    MechanicRide.create!(ride: @coaster, mechanic: @steve)
    MechanicRide.create!(ride: @tower, mechanic: @steve)

    visit "/mechanics/#{@steve.id}"
    
    
    expect(page).to have_content("Name: #{@steve.name}")
    expect(page).to have_content("Years of experience: #{@steve.years_experience}")
    expect(page).to have_content("Rides: #{@tower.name} #{@coaster.name}")
  end
end