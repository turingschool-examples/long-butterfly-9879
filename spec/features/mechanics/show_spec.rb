require 'rails_helper'

RSpec.describe 'Mechanic', type: :feature do
  describe 'Mechanic Show Page' do
    let!(:kara) { Mechanic.create!(name: "Kara Smith") }

    before do
      @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
      @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
      @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
      @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

      RideMechanic.create!(ride_id: @hurler.id, mechanic_id: kara.id)
      RideMechanic.create!(ride_id: @scrambler.id, mechanic_id: kara.id)
    end

    describe 'As a user' do 
      context "When I visit a mechanic show page" do

        before do
          visit mechanic_path(kara.id)
        end

        it 'I see their name and all of their attributes' do
          within('section#mechanic_information') do
            expect(page).to have_content(kara.name)
            expect(page).to have_content(kara.years_experience)
          end
        end

        it 'I see the names of all rides they are working on' do
          save_and_open_page
          within("section#mechanics_rides") do
            expect(page).to have_content(kara.rides.first.name)
            expect(page).to have_content(kara.rides.second.name)
          end
        end
      end
    end
  end
end