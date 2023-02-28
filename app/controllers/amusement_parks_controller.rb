class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    @mechanics = @amusement_park.mechanics.distinct
    @rides = @amusement_park.rides.distinct
  end
end