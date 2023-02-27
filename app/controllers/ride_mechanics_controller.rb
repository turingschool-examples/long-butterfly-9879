class RideMechanicsController < ApplicationController
	def create
		RideMechanic.create!(ride_mechanic_params)
		redirect_to mechanic_path(params[:mechanic_id])
	end


	private

	def ride_mechanic_params
		params.permit(:mechanic_id, :ride_id)
	end
end