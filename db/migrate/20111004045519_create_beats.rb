class CreateBeats < ActiveRecord::Migration
  def change
    create_table :beats do |t|
      t.string :title, :null => false
      t.integer :creator_id

      t.timestamps
    end

    add_index :beats, [ :creator_id, :created_at ]
  end
end
