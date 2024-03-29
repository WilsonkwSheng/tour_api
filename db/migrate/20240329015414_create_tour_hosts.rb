class CreateTourHosts < ActiveRecord::Migration[7.0]
  def change
    create_table :tour_hosts do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.text :description

      t.timestamps
    end
  end
end
