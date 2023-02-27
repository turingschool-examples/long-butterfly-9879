class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanic_rides 
  has_many :mechanics, through: :mechanic_rides

  def avg_years_experience 
    mechanics.average(:years_experience)
  end
end