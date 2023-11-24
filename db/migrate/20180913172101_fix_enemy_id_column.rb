class FixEnemyIdColumn < ActiveRecord::Migration[5.2]
  def change
  	rename_column :game_data, :enemy_is, :enemy_id
  end
end
