class CreateItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :itineraries do |t|
      t.references :tour, null: false, foreign_key: true
      t.date :date, null: false
      t.integer :day, null: false
      t.time :start_at, null: false
      t.time :end_at, null: false
      t.string :title
      t.text :description

      t.timestamps
    end

    add_index :itineraries, [:tour_id, :date, :start_at, :end_at], unique: true
  end
end
