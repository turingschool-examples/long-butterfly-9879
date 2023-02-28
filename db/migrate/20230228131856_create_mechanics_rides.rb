class CreateMechanicsRides < ActiveRecord::Migration[5.2]
  def change
    create_table :mechanics_rides do |t|
      t.references :mechanic, foreign_key: true
      t.references :ride, foreign_key: true

      t.timestamps
    end
  end
end
