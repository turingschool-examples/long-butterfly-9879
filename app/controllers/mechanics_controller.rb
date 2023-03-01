class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
  end

  def update
    added = RideMechanic.add_to_workload(params)
    @mechanic = Mechanic.find(params[:id])
    if added.save
      
      redirect_to mechanic_path(added.mechanic_id)
    end
  end
end