class RideMechanicsController < ApplicationController
  def create
    RideMechanic.create!(ride_mechanic_params)
    redirect_to "/mechanics/#{params[:mechanic_id]}"
  end

private
 def ride_mechanic_params
    params.permit(:ride_id, :mechanic_id)
 end
end