class AmusementParksController < ApplicationController
	def show
		@amusement_park = AmusementPark.find(params[:id])
		@rides = @amusement_park.rides.with_mechanic_average_experience
		@mechanics = @amusement_park.mechanics.distinct
	end
end