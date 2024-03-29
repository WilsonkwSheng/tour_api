class CreateTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :region, null: false
      t.string :city, null: false
      t.string :travel_type, null: false
      t.references :tour_host, null: false, foreign_key: true

      t.timestamps
    end
  end
end
