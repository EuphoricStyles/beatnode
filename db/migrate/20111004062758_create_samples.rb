class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps
    end

    add_index :samples, [ :user_id, :created_at ]
  end
end
