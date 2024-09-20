class CreateAdvertisements < ActiveRecord::Migration[6.1]
  def change
    create_table :advertisements do |t|
      t.timestamps
      t.references :vehicle, null: false, foreign_key: true
      t.text :display
    end
  end
end
