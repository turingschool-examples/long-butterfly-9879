class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics

  def self.unique_mechanics
    joins(:rides).distinct
  end
end