require 'rails_helper'

RSpec.describe "Mechanics Show Page", type: :feature do

  let!(:fred) { Mechanic.create!(name: "Fred", years_experience: 4) }

  describe 'As a user, when I visit a mechanic show page' do
    before do
      visit "/mechanics/#{fred.id}"
    end
    it 'I see Mechanic info' do
      expect(page).to have_content('Name: Fred')
      expect(page).to have_content('Years Experience: 4')
    end
  end
end