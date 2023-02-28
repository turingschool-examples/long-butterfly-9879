class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanic_rides, through: :rides
  has_many :mechanics, through: :mechanic_rides

  def park_mechanics
    require 'pry'; binding.pry
    rides.joins(:mechanics)
    .select("mechanics.name")
    .distinct
  end
end