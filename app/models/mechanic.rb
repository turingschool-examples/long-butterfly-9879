class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics

  def self.find_all_mechanics_for_a_park(park_id)
    self.joins(:rides).where(rides: {amusement_park_id: park_id}).distinct
  end
end