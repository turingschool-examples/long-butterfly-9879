class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    @working_mechanics = @amusement_park.uniq_working_mechanics
  end
end