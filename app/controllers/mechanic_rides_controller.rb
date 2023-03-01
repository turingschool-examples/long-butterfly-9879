class MechanicRidesController < ApplicationController
  def create
    mechanic = Mechanic.find(params[:mechanic_id])
    MechanicRide.create(mechanic_ride_param)

    redirect_to mechanic_path(mechanic)
  end


  private
  
  def mechanic_ride_param
    params.permit(:mechanic_id, :ride_id)
  end
  
end