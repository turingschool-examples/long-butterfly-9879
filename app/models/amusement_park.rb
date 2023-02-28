class AmusementPark < ApplicationRecord
  has_many :rides

  def list_of_mechanics
    Mechanic.joins(:mechanic_rides).distinct.pluck(:name)
    binding.pry
  end
end