class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    @park_mechanics = @amusement_park.park_mechanics
  end
end