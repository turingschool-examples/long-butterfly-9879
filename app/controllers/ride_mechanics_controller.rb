class RideMechanicsController < ApplicationController

  def create
    ridemechanic = RideMechanic.new(ride_id: params[:id], mechanic_id: params[:mechanic_id])
    if ridemechanic.save
      redirect_to mechanic_path(params[:mechanic_id])
    else
      flash[:message] = 'Invalid id'
      redirect_to mechanic_path(params[:mechanic_id])
    end
  end
end