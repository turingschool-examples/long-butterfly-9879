class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :ride_mechanics, through: :rides
  has_many :mechanics, through: :ride_mechanics

  def mechanic_names
    mechanics.distinct.pluck(:name)
  end

  def avg_mech_ride_exp
    rides.joins(:mechanics).group("rides.id").select("rides.*, AVG(mechanics.years_experience) AS avg_experience").order("avg_experience DESC")
  end
end