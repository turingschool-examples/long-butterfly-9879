class RideMechanic < ApplicationRecord
  belongs_to :ride
  belongs_to :mechanic

  def self.add_to_workload(params)
    created = RideMechanic.create(ride_id: params[:ride_id], mechanic_id: params[:id])
  end
end