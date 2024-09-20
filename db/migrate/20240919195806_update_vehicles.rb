class UpdateVehicles < ActiveRecord::Migration[6.1]
  def change
    add_reference :vehicles, :vehicle_type, null: false, foreign_key: true
  end
end
