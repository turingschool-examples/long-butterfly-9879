class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
  end

  def update
    @mechanic = Mechanic.find(params[:id])
    @ride = Ride.find(params[:ride_id])
    MechanicRide.create!(mechanic_id: @mechanic.id, ride_id: @ride.id)
    redirect_to "/mechanics/#{@mechanic.id}"
  end
end