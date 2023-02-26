class AmusementParksController < ActionController::Base

  def show
    @amusement_park = AmusementPark.find(params[:id])
    @mechanics = @amusement_park.list_mechanics_uniq
    @rides_and_avg_exp = @amusement_park.list_rides_and_mech_exp
  end
end
