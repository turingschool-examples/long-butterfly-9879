class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :mechanic_rides
  has_many :rides, through: :mechanic_rides

  def park_mechanics
    self.mechanics.distinct
  end
end