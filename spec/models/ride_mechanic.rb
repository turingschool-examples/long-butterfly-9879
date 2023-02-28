require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  describe 'relationships' do
    it { should belong_to(:ride) }
    it { should belong_to(:mechanic) }
  end
end