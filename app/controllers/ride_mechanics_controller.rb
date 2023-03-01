class RideMechanicsController < ApplicationController
  def create
    @mechanic = Mechanic.find(params[:ride_mechanic][:mechanic_id])
    new_mechanic_ride = RideMechanic.new(mechanic_id:@mechanic.id, ride_id:params[:ride_mechanic][:ride_id])
    if new_mechanic_ride.save
      redirect_to mechanic_path(@mechanic)
      flash[:notice] = "Mechanic Workload Updated Successfully"
    else
      flash[:notice] = "Mechanic Workload Updated Failed: Inviable Ride ID"
      render 'mechanics/show'
    end
  end

  private

  def mechanic_params
    params.require(:mechanic).permit(:id)
  end
end