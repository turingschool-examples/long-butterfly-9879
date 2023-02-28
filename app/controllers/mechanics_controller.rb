class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
    @mechanic_rides = Mechanic.mechanics_rides(params[:id])
  end
end