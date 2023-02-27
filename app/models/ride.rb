class Ride < ApplicationRecord
  belongs_to :amusement_park
  has_many :mechanic_rides
  has_many :mechanics, through: :mechanic_rides

  def avg_exp
    mechanics.average(:years_experience)
    #tried this: mechanics.order("average(years_experience)") but only got AR objects to return. I ran out of time
  end
end