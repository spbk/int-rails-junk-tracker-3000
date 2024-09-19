class CreateDoors < ActiveRecord::Migration[6.1]
  def change
    create_table :doors do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.boolean :sliding, null: false, default: false
      t.timestamps
    end
  end
end
