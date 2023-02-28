class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
    @mechanic_rides = @mechanic.rides
  end
end