class AddIndexOnTourHosts < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :tour_hosts, :email, unique: true, algorithm: :concurrently
  end
end
