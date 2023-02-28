class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanic_rides, through: :rides
  has_many :mechanics, through: :mechanic_rides

  def list_of_mechanics
    mechanics.distinct.pluck(:name)
  end
end