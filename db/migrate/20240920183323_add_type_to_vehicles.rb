class AddTypeToVehicles < ActiveRecord::Migration[6.1]
  def change
    add_column :vehicles, :type, :string
  end
end
