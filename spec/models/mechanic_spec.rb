require 'rails_helper'

RSpec.describe Mechanic, type: :model do
  it { should have_many(:ride_mechanics)}
  it { should have_many(:rides).through(:ride_mechanics)}
end
