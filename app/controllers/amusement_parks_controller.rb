class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    require 'pry'; binding.pry
    @mechanics = @amusement_park.park_mechanics
  end
end