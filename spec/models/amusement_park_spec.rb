require 'rails_helper'

RSpec.describe AmusementPark, type: :model do
  describe 'relationships' do
    it { should have_many(:rides) }
    it { should have_many(:mechanics).through(:rides)}
  end

  describe 'instance methods' do
    it "can create unique list of mecahnics working on that parks rides" do
      elitch = AmusementPark.create!(name: "Elitch Gardens", admission_cost: 50)

      coaster = Ride.create!(name: 'Zoom', thrill_rating: 8, open: true, amusement_park: elitch)
      wheel = Ride.create!(name: 'Wheel of danger', thrill_rating: 6, open: false, amusement_park: elitch)
      slide = Ride.create!(name: 'Slide', thrill_rating: 4, open: true, amusement_park: elitch)

      mechanic_1 = Mechanic.create!(name: 'Matt Smith', years_experience: 2)

      ride_mech_1 = RideMechanic.create(ride: coaster, mechanic: mechanic_1)
      ride_mech_2 = RideMechanic.create(ride: wheel, mechanic: mechanic_1)

      mechanic_2 = Mechanic.create!(name: 'Stephanie Smith', years_experience: 3)

      ride_mech_3 = RideMechanic.create(ride: coaster, mechanic: mechanic_2)
      ride_mech_4 = RideMechanic.create(ride: wheel, mechanic: mechanic_2)
      ride_mech_5 = RideMechanic.create(ride: slide, mechanic: mechanic_2)
      
      expect(elitch.list_mechanics_uniq).to eq([mechanic_1, mechanic_2])

      mechanic_3 = Mechanic.create!(name: 'Sam Smith', years_experience: 11)
      ride_mech_5 = RideMechanic.create(ride: wheel, mechanic: mechanic_3)
      ride_mech_6 = RideMechanic.create(ride: slide, mechanic: mechanic_3)

      expect(elitch.list_mechanics_uniq).to eq([mechanic_1, mechanic_2, mechanic_3])
    end

    it "list all of the park's rides, ordered by the average experience of the mechanics working on that ride" do
      elitch = AmusementPark.create!(name: "Elitch Gardens", admission_cost: 50)

      coaster = Ride.create!(name: 'Zoom', thrill_rating: 8, open: true, amusement_park: elitch)
      wheel = Ride.create!(name: 'Wheel of danger', thrill_rating: 6, open: false, amusement_park: elitch)
      slide = Ride.create!(name: 'Slide', thrill_rating: 4, open: true, amusement_park: elitch)

      mechanic_1 = Mechanic.create!(name: 'Matt Smith', years_experience: 2)
      ride_mech_1 = RideMechanic.create(ride: coaster, mechanic: mechanic_1)
      ride_mech_2 = RideMechanic.create(ride: wheel, mechanic: mechanic_1)

      mechanic_2 = Mechanic.create!(name: 'Stephanie Smith', years_experience: 3)
      ride_mech_3 = RideMechanic.create(ride: coaster, mechanic: mechanic_2)
      ride_mech_4 = RideMechanic.create(ride: wheel, mechanic: mechanic_2)
      ride_mech_5 = RideMechanic.create(ride: slide, mechanic: mechanic_2)

      mechanic_3 = Mechanic.create!(name: 'Sam Smith', years_experience: 11)
      ride_mech_5 = RideMechanic.create(ride: wheel, mechanic: mechanic_3)
      ride_mech_6 = RideMechanic.create(ride: slide, mechanic: mechanic_3)

      expect(elitch.list_rides_and_mech_exp).to eq([coaster, wheel, slide])

      mechanic_4 = Mechanic.create!(name: 'Joe Smith', years_experience: 100)
      ride_mech_5 = RideMechanic.create(ride: coaster, mechanic: mechanic_4)
 
      expect(elitch.list_rides_and_mech_exp).to eq([wheel, slide, coaster])  
    end
  end
end