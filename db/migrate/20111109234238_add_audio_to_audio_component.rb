class AddAudioToAudioComponent < ActiveRecord::Migration
  def change
    add_column :audio_components, :audio, :string
  end
end
