class MechanicRidesController < ApplicationController
  def create
    @mechanic = Mechanic.find(mechanic_ride_params[:mechanic_id])
    MechanicRide.create_new_mechanic_ride(mechanic_ride_params)
    redirect_to mechanic_path(@mechanic)
  end

  private
  def mechanic_ride_params
    params.permit(:mechanic_id, :ride_id)
  end
end