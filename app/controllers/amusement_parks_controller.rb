class AmusementParksController < ApplicationController
  
  def show
    @park = AmusementPark.find(params[:id])
    @park_mechanics = @park.park_mechanics
  end
end