class MechanicRides < ActiveRecord::Migration[5.2]
  def change
    create_table :mechanic_rides do |t|
      t.belongs_to :ride
      t.belongs_to :mechanic

      t.timestamps
    end
  end
end
