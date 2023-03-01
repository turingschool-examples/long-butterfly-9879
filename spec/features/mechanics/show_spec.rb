require 'rails_helper'

describe 'As a user' do
  describe 'when i visit a mechanic show page' do

    before :each do
      @m1 = Mechanic.create!(name: 'Billy Bob', years_experience: 13)
      @p = AmusementPark.create!(name: 'Upside Down Town', admission_cost: 20)
      @r1 = @p.rides.create!(name: 'Vom Bomb', thrill_rating: 7, open: false)
      @r2 = @p.rides.create!(name: 'Bad Hair Day', thrill_rating: 4, open: false)
      @r3 = @p.rides.create!(name: 'SpiderMan', thrill_rating: 6, open: false)
      @r4 = @p.rides.create!(name: 'Demogorgon' , thrill_rating: 9, open: false)


      RideMechanic.create!(ride_id: @r1.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r2.id, mechanic_id: @m1.id)
      RideMechanic.create!(ride_id: @r3.id, mechanic_id: @m1.id)

      visit mechanic_path(@m1)
    end
    
    describe 'USER STORY 1' do

      it 'I see their name, years of experience, and the names of all rides they are working on' do
        expect(page).to have_content('Billy Bob')
        expect(page).to have_content('Years of Experience: 13')

        within('#rides') do
          expect(page).to have_content('Vom Bomb')
          expect(page).to have_content('Bad Hair Day')
          expect(page).to have_content('SpiderMan')
        end 
      end

      describe 'USER STORY 2' do
        it 'I see a form to add a ride to their workload' do
          within('#add_ride') do
            expect(page).to have_content("Add Ride to Mechanic's Workload")

            expect(page).to have_field('ride_mechanic[ride_id]')
          end
        end

        it "I fill in that field with an id of an existing ride and click Submit I’m taken back to that mechanic's show page" do
          fill_in 'ride_mechanic[ride_id]', with: @r4.id
          click_button 'Add Ride'

          within('#add_ride') do
            expect(page.current_path).to eq(mechanic_path(@m1))
          end
        end

        it "And I see the name of that newly added ride on this mechanic's show page" do
          fill_in 'ride_mechanic[ride_id]', with: @r4.id
          click_button 'Add Ride'

          
          expect(page).to have_content("Mechanic Workload Updated Successfully")
          
          within('#rides') do
            expect(page).to have_content('Demogorgon')
          end
          
          expect(@r4.mechanics).to include(@m1)
        end

        it 'Does not add the ride to the mechanic workload if the ride does not exist' do
          fill_in 'ride_mechanic[ride_id]', with: "an_id"
          click_button 'Add Ride'

          expect(page).to have_content("Mechanic Workload Updated Failed: Inviable Ride ID")
          
          within('#rides') do
            expect(page).to have_no_content('Demogorgon')
          end

          expect(@r4.mechanics).to eq([])
        end
      end
    end
  end
end