class CreateMechanics < ActiveRecord::Migration[5.2]
  def change
    create_table :mechanics do |t|
      t.string :name
      t.integer :years_experience
      t.references :ride, foreign_key: true
      t.timestamps
    end
  end
end
