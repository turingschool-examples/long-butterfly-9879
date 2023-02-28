class MechanicsController < ApplicationController

  def show
    @mechanic = Mechanic.find(params[:id])
    @rides = @mechanic.rides
  end

  def create
    ride_mechanic = RideMechanic.create!(mechanic_id: params[:id], ride_id: params[:ride_id])
    redirect_to "/mechanics/#{params[:id]}"
  end
end