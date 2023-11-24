class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
    #add_index :shops, :user
    #add_index :shops, :item
    add_index :shops, [:user_id, :item_id]
  end
end
