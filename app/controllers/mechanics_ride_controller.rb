class MechanicsRideController < ApplicationController
	def create
		@mechanic = Mechanic.find(params[:id])
		@ride = Ride.find(params[:ride_id])
		
		if MechanicsRide.create!(mechanic: @mechanic, ride: @ride)
			flash[:success] = "Ride added"
			redirect_to "/mechanics/#{@mechanic.id}"
		else
			flash[:error] = "Ride not added"
			redirect_to "/mechanics/#{@mechanic.id}"
		end
	end
end