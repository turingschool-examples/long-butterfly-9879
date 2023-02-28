class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanic_rides, through: :rides
  has_many :mechanics, through: :mechanic_rides
  
  def rides_with_average_mech_years
   x = rides.joins(:mechanics).select('rides.*, avg(mechanics.years_of_experience) as average_years').group('rides.id').order('average_years desc')
  end
end