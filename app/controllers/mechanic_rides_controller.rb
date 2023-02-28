class MechanicRidesController < ApplicationController
  def create
    mechanic = Mechanic.find(params[:id])
    ride = Ride.find(params[:ride_id])
    mechanic_ride = MechanicRide.create!(mechanic_id: params[:id], ride_id: params[:ride_id])
    redirect_to mechanic_path(mechanic)
    if mechanic_ride.save!
      flash[:info] = "Added Ride"
    else
      flash[:error] = "Error: #{error_message(mechanic_ride.errors)}"
    end
  end

  private 
  def mechanic_rides_params
    params.permit(:ride_id, :mechanic_id)
  end
end