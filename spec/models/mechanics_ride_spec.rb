require 'rails_helper'

RSpec.describe MechanicsRide, type: :model do
  it {should belong_to :mechanic}
	it {should belong_to :ride}
end
