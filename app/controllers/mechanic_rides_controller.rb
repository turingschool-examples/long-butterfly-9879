class MechanicRidesController < ApplicationController
  def create
    mechanic_ride = MechanicRide.new(mechanic_id: params[:id], ride_id: params[:ride_id])
    
    redirect_to "/mechanics/#{mechanic_ride.mechanic_id}"
    if mechanic_ride.save!
      flash[:info] = "Added Ride"
    else
      flash[:error] = "Error: #{error_message(mechanic_ride.errors)}"
    end
  end
end