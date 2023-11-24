class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :actor_id
      t.integer :dest_id
      t.integer :category
      t.integer :new_best_score
      t.datetime :read_at

      t.timestamps
    end
    add_index :notifications, :dest_id
  end
end
