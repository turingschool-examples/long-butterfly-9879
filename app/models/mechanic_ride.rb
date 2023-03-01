class MechanicRide < ApplicationRecord
  belongs_to :mechanic
  belongs_to :ride

  def self.create_new_mechanic_ride(item_params)
    create(item_params)
  end
end