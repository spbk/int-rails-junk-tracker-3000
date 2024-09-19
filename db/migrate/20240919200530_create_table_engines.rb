class CreateTableEngines < ActiveRecord::Migration[6.1]
  def change
    create_table :engines do |t|
      t.references :vehicle, null: false, foreign_key: true
      t.string :status, null: false, default: "works"
      t.timestamps
    end
  end
end
