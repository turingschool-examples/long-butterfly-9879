class AmusementPark < ApplicationRecord
  has_many :rides

  validates_presence_of :name, :admission_cost
  validates_numericality_of :admission_cost

  def unique_mechanics
    Mechanic.joins(rides: :amusement_park).where("amusement_parks.id = ?", self.id).distinct
  end
end