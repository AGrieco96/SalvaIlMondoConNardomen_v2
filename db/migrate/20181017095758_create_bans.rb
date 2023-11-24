class CreateBans < ActiveRecord::Migration[5.2]
  def change
    create_table :bans do |t|
      t.integer :user_id
      t.boolean :request
      t.datetime :day_ban
      t.timestamps
    end

    add_index :bans, [:user_id]
  end
end
