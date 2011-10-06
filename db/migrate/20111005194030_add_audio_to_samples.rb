class AddAudioToSamples < ActiveRecord::Migration
  def change
    add_column :samples, :audio, :string
  end
end
