class CreateFeedEvents < ActiveRecord::Migration
  def change
    create_table :feed_events do |t|
      t.integer :user_id
      t.integer :feedable_id
      t.string :feedable_type

      t.timestamps
    end

    add_index :feed_events, :user_id
    add_index :feed_events, :feedable_id
    add_index :feed_events, :feedable_type
    add_index :feed_events, [ :feedable_id, :feedable_type ], :unique => true
  end
end
