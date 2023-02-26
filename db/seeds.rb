# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AmusementPark.destroy_all
Ride.destroy_all
Mechanic.destroy_all
RideMechanic.destroy_all

@six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
@universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

@hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
@scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
@ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

@jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

@mechanic_1 = Mechanic.create!(name: 'Stephanie Smith', years_experience: 2)
@mechanic_2 = Mechanic.create!(name: 'Matt Smith', years_experience: 6)

@ride_mechanic1 = RideMechanic.create!(mechanic: @mechanic_1, ride: @hurler)
@ride_mechanic2 = RideMechanic.create!(mechanic: @mechanic_1, ride: @scrambler)
@ride_mechanic3 = RideMechanic.create!(mechanic: @mechanic_1, ride: @ferris)

@ride_mechanic1 = RideMechanic.create!(mechanic: @mechanic_2, ride: @hurler)
@ride_mechanic2 = RideMechanic.create!(mechanic: @mechanic_2, ride: @scrambler)

