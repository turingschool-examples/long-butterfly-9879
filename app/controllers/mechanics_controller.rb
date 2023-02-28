class MechanicsController < ApplicationController
  def show
    @mechanic = Mechanic.find(params[:id])
  end
  
  def update
    @mechanic = Mechanic.find(params[:id])
    new_mechanic_ride = RideMechanic.new(mechanic_id:@mechanic.id, ride_id:params[:mechanic][:ride_id])
    if new_mechanic_ride.save
      redirect_to mechanic_path(@mechanic)
      flash[:notice] = "Mechanic Workload Updated Successfully"
    else
      flash[:notice] = "Mechanic Workload Updated Failed: Inviable Ride ID"
      render :show
    end
  end

  private

  def mechanic_params
    params.require(:mechanic).permit(:id)
  end
end