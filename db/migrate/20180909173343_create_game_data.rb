class CreateGameData < ActiveRecord::Migration[5.2]
  def change
    create_table :game_data do |t|
      t.integer :user_id
      t.integer :money
      t.integer :level
      t.integer :exp

      t.timestamps
    end
    add_index :game_data, :user_id, unique: true
  end
end
