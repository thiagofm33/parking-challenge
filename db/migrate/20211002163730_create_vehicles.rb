class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :plate, null: false, limit: 8
      t.integer :vehicle_type, limit: 2
      t.string :make
      t.string :model
      t.string :color

      t.timestamps
    end

    add_index :vehicles, :plate, unique: true
  end
end
