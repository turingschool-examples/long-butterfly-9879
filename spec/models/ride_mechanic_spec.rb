require 'rails_helper'

RSpec.describe RideMechanic, type: :model do
  it { should belong_to(:mechanic) }
  it { should belong_to(:ride) }

end
