class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :type
      t.integer :level
      t.integer :price

      t.timestamps
    end
    add_index :items, :name
    add_index :items, :type
  end
end
