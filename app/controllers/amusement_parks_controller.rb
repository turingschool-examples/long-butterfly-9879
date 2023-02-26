class AmusementParksController < ApplicationController

  def show
    @amusement_park = AmusementPark.find(params[:id])
    @unique_mechanics = @amusement_park.rides.select_unique_mechanics
    @all_rides= @amusement_park.rides.years_experience_rides
  end
end