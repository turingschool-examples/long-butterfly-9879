class MechanicRidesController < ApplicationController
  def create
    mr = MechanicRide.new(mechanic_id: params[:mechanic_id], ride_id: params[:ride_id]) 

    if !mr.save
    flash[:alert] = mr.errors.full_messages
    end
    redirect_to mechanic_path(params[:mechanic_id])
  end
end