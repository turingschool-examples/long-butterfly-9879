class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    # @amusement_park_mechanics = @amusement_park.list_of_mechanics
  end
end