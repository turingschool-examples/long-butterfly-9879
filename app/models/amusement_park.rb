class AmusementPark < ApplicationRecord
  has_many :rides

  validates_presence_of :name, :admission_cost
  validates_numericality_of :admission_cost

  def unique_mechanics
    Mechanic.joins(rides: :amusement_park)
    .where("amusement_parks.id = ?", self.id)
    .distinct
  end

  def mechanics_average_experience_by_ride
    self.rides
    .joins(:mechanics)
    .select("rides.*, avg(mechanics.years_experience) as average_experience")
    .group(:id)
    .order("average_experience desc")
  end
end