class CreateAudioComponents < ActiveRecord::Migration
  def change
    create_table :audio_components do |t|
      t.integer :owner_id
      t.string :owner_type

      t.timestamps
    end

    add_index :audio_components, :owner_id
    add_index :audio_components, [:owner_id, :owner_type], :unique => true
  end
end
