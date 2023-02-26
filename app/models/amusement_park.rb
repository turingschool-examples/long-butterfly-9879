class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanic_rides, through: :rides 
  has_many :mechanics, through: :mechanic_rides

  def mechanics_at_park 
    mechanics.distinct
  end
end