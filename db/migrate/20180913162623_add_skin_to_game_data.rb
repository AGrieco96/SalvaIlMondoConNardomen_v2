class AddSkinToGameData < ActiveRecord::Migration[5.2]
  def change
    add_column :game_data, :skin_id, :integer
  end
end
