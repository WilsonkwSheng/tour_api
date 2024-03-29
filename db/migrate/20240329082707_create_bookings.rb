class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tour, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bookings, [:customer_id, :tour_id], unique: true
  end
end
