class AmusementParksController < ApplicationController
  def show
    @park = AmusementPark.find(params[:id])
    @mechanics = @park.mechanic_names
    @rides = @park.rides
  end
end