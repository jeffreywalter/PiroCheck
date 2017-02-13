class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :url
      t.integer :notify_count, default: 0
      t.timestamps
    end
  end
end
