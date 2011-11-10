class RemoveAudioFromBeats < ActiveRecord::Migration
  def up
    remove_column :beats, :audio
  end

  def down
    add_column :beats, :audio, :string
  end
end
