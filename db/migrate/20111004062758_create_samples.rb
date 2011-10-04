class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :description
      t.integer :owner_id

      t.timestamps
    end

    add_index :samples, [ :owner_id, :created_at ]
  end
end
