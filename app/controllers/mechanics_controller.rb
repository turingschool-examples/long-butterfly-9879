class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
    @rides = @mechanic.rides
  end

  def create
    RideMechanic.create!(ride_id: params[:ride_id], mechanic_id: params[:id])
    redirect_to "/mechanics/#{params[:id]}"
  end
end