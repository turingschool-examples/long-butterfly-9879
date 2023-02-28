class MechanicRidesController < ApplicationController
  def create
    mr = MechanicRide.new(mechanic_id: params[:id], ride_id: params[:ride_id])
    
    if mr.save
      redirect_to "/mechanics/#{params[:id]}"
    else
      flash[:error] = mr.errors.full_messages
      render :new
    end
  end
end