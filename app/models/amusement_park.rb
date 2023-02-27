class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanic_rides, through: :rides 
  has_many :mechanics, through: :mechanic_rides

  def mechanics_at_park 
    mechanics.distinct
  end

  def order_rides_by_mechanic_experience 
    rides.joins(:mechanics).select('rides.*, avg(mechanics.years_experience) as average').group(:id).order('average desc')
  end
end