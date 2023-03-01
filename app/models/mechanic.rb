class Mechanic < ApplicationRecord
  has_many :ride_mechanics
  has_many :rides, through: :ride_mechanics

  def self.add_to_workload(params)
    RideMechanic.create(ride_id: params[:ride_id], mechanic_id: params[:format])
  end
end