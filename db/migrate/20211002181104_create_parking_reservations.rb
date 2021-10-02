class CreateParkingReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :parking_reservations do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.datetime :check_in_at, null: false
      t.datetime :check_out_at
      t.datetime :paid_at

      t.timestamps
    end
  end
end
