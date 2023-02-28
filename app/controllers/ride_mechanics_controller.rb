class RideMechanicsController < ApplicationController
  def create
    ride = Ride.find(params[:ride_id])
    ride_mechanic = RideMechanic.create!(ride: ride, mechanic_id: params[:id])

    redirect_to "/mechanics/#{params[:id]}"
  end
end