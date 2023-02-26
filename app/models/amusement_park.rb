class AmusementPark < ApplicationRecord
  has_many :rides
  has_many :mechanics, through: :rides

  def list_mechanics_uniq
    self.mechanics.distinct
  end

  def list_rides_and_mech_exp
    self.rides.joins(:mechanics)
    .select("rides.*, avg(mechanics.years_experience) as average_experience")
    .group("rides.id")
    .order("average_experience")
  end
end