class MechanicRidesController < ApplicationController

  def create
    mechanic_ride = MechanicRide.new(mechanic_ride_params)

    if mechanic_ride.save 
      redirect_to "/mechanics/#{params[:mechanic_id]}"
    end
  end

  private 

  def mechanic_ride_params
    params.permit(:mechanic_id, :ride_id)
  end
end