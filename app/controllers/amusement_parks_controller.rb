class AmusementParksController < ApplicationController
  def show
    @amusement_park = AmusementPark.find(params[:id])
    @rides = @amusement_park.rides
    require 'pry'; binding.pry
  end
end