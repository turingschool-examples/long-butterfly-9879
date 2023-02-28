class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
  end
end