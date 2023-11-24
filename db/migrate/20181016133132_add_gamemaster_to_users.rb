class AddGamemasterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gm, :boolean , default: false
  end
end
