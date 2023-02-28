class CreateAmusementParkMechanics < ActiveRecord::Migration[5.2]
  def change
    create_table :amusement_park_mechanics do |t|
      t.references :amusement_park, foreign_key: true
      t.references :mechanic, foreign_key: true
    end
  end
end
