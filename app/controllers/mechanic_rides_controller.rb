class MechanicRidesController < ApplicationController 
  def create 
    mechanic = Mechanic.find(params[:mechanic_id])
    MechanicRide.create!(mechanic_rides_params)

    redirect_to mechanic_path(mechanic)
  end

  private 
  def mechanic_rides_params 
    params.permit(:ride_id, :mechanic_id)
  end
end