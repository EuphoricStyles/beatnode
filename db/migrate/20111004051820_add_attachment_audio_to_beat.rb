class AddAttachmentAudioToBeat < ActiveRecord::Migration
  def self.up
    add_column :beats, :audio_file_name, :string
    add_column :beats, :audio_content_type, :string
    add_column :beats, :audio_file_size, :integer
    add_column :beats, :audio_updated_at, :datetime
  end

  def self.down
    remove_column :beats, :audio_file_name
    remove_column :beats, :audio_content_type
    remove_column :beats, :audio_file_size
    remove_column :beats, :audio_updated_at
  end
end
