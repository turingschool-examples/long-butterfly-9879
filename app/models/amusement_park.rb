class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanic_rides, through: :rides
  has_many :mechanics, through: :mechanic_rides

  def park_mechanics
    self.mechanics.distinct
  end
end