class MechanicRidesController < ApplicationController
  def create
    @ride = Ride.find(params[:ride_id])
    ride_assignment = MechanicRide.new(mechanic_id: params[:id], ride_id: @ride.id)
    if !ride_assignment.save
      redirect_to root_path
    end
    redirect_to "/mechanics/#{params[:id]}"
  end
end