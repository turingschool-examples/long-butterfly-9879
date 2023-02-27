class AmusementParksController < ApplicationController
	def show
		@amusement_park = AmusementPark.find(params[:id])
		@mechanics = @amusement_park.mechanics.distinct
	end
end