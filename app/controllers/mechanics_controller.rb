class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
    @rides = @mechanic.rides
  end
end