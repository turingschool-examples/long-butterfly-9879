class MechanicRides < ActiveRecord::Migration[5.2]
  def change
    create_table :mechanic_rides do |t|
      t.references :mechanic, foreign_keys: true
      t.references :ride, foreign_keys: true

      t.timestamps
    end
  end
end
