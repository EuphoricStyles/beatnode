class CreateSampleBorrows < ActiveRecord::Migration
  def change
    create_table :sample_borrows do |t|
      t.integer :sample_id
      t.integer :user_id

      t.timestamps
    end

    add_index :sample_borrows, :sample_id
    add_index :sample_borrows, :user_id
    add_index :sample_borrows, [ :sample_id, :user_id ], :unique => true
  end
end
