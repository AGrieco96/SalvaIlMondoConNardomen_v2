class AddGamefounderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gf, :boolean , default: false
  end
end
