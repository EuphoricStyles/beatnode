class AddAudioToBeats < ActiveRecord::Migration
  def change
    add_column :beats, :audio, :string
  end
end
