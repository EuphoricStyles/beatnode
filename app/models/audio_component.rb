class AudioComponent < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  belongs_to :owner, :polymorphic => true

  #validates_presence_of :owner_id
  #validates_presence_of :owner_type

  mount_uploader :audio, AudioUploader

  validates :audio, :presence => true, :file_size => { :maximum => 10.megabytes }

  def basename
    @basename ||= File.basename(self.audio.url)
  end

  def display_name
    @display_name ||= truncate(basename, :length => 50)
  end

  def filetype
    MIME::Types.type_for(basename)
  end
end
