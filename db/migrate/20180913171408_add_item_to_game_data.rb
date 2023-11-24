class AddItemToGameData < ActiveRecord::Migration[5.2]
  def change
    add_column :game_data, :enemy_is, :integer
    add_column :game_data, :sword_id, :integer
    add_column :game_data, :landscape_id, :integer
  end
end
