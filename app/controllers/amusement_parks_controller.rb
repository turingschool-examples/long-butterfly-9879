class AmusementParksController < ApplicationController

  def show
    @park = AmusementPark.find(params[:id])
    @mechanics = Mechanic.find_all_mechanics_for_a_park(@park.id)
  end
end