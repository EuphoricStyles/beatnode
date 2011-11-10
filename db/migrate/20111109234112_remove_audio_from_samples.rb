class RemoveAudioFromSamples < ActiveRecord::Migration
  def up
    remove_column :samples, :audio
  end

  def down
    add_column :beats, :audio, :string
  end
end
