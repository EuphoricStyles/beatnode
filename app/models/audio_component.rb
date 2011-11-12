class AudioComponent < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  belongs_to :owner, :polymorphic => true

  mount_uploader :audio, AudioUploader

  validates :audio, :presence => true, :file_size => { :maximum => 10.megabytes }

  def display_name
    @display_name ||= truncate(File.basename(audio.path), :length => 50)
  end

  def content_type
    @content_type ||= MIME::Types.type_for(audio.path).first.to_s
  end
end
