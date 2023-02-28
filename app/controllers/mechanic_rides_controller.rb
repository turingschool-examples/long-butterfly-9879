class MechanicRidesController < ApplicationController
  def create
    mechanic_ride = MechanicRide.new(ride_id: params[:ride_id], mechanic_id: params[:id])

    mechanic_ride.save
    redirect_to "/mechanics/#{params[:id]}"
  end
end