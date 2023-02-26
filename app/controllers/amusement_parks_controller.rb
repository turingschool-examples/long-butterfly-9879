class AmusementParksController < ActionController::Base

  def show
    @amusement_park = AmusementPark.find(params[:id])
    @mechanics = @amusement_park.list_mechanics_uniq
  end
end
