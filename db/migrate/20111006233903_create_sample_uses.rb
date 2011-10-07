class CreateSampleUses < ActiveRecord::Migration
  def change
    create_table :sample_uses do |t|
      t.integer :beat_id
      t.integer :sample_id

      t.timestamps
    end

    add_index :sample_uses, :beat_id
    add_index :sample_uses, :sample_id
    add_index :sample_uses, [ :beat_id, :sample_id ], :unique => true
  end
end
