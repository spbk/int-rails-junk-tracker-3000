class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :nickname
      t.string :registration_id
      t.integer :mileage, default: 0, null: false
      t.timestamps
    end
  end
end
