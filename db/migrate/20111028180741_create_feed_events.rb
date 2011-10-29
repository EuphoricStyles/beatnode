class CreateFeedEvents < ActiveRecord::Migration
  def change
    create_table :feed_events do |t|
      t.integer :user_id
      t.integer :subject_id
      t.string :subject_type

      t.timestamps
    end

    add_index :feed_events, :user_id
    add_index :feed_events, :subject_id
    add_index :feed_events, :subject_type
    add_index :feed_events, [ :subject_id, :subject_type ], :unique => true
  end
end
