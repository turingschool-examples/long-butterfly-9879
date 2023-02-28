class AmusementParksController < ApplicationController
	def show
		@park = AmusementPark.find(params[:id])
		@distinct = @park.uniq_mechanics
	end
end