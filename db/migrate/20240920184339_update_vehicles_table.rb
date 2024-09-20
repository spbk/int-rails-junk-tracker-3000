class UpdateVehiclesTable < ActiveRecord::Migration[6.1]
  def change
    remove_reference :vehicles, :vehicle_type, foreign_key: true

    drop_table :vehicle_types
  end
end
