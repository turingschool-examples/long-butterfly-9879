# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AmusementPark.destroy_all
Ride.destroy_all

@six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
@universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

@hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
@scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
@ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

@jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)
@park = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
@ride1 = @park.rides.create!(name: "The Hurler", thrill_rating: 7, open: false)
@ride2 = @park.rides.create!(name: "Tower of Doom", thrill_rating: 10, open: true)
@ride3 = @park.rides.create!(name: "Tea Cups", thrill_rating: 3, open: true)
@mechanic1 = Mechanic.create!(name: "Kara Smith", years_experience: 11)
@mechanic2 = Mechanic.create!(name: "Karl Smits", years_experience: 11)
MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride1.id)
MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @ride2.id)