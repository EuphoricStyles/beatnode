class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :description
      t.integer :beat_id

      t.timestamps
    end

    add_index :samples, :beat_id
  end
end
