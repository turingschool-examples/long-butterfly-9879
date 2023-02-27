class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    @park_mechanics = @amusement_park.mechanics.uniq
  end
end