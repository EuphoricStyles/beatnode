class CreateBeats < ActiveRecord::Migration
  def change
    create_table :beats do |t|
      t.string :title
      t.integer :user_id

      t.timestamps
    end

    add_index :beats, [ :user_id, :created_at ]
  end
end
