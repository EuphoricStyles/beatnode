class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :watcher_id
      t.integer :watched_id

      t.timestamps
    end

    add_index :user_relationships, :watcher_id
    add_index :user_relationships, :watched_id
    add_index :user_relationships, [:watcher_id, :watched_id], :unique => true
  end
end
