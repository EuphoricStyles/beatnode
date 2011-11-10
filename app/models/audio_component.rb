class AudioComponent < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  belongs_to :owner, :polymorphic => true

  validates_presence_of :owner_id
  validates_presence_of :owner_type

  mount_uploader :audio, AudioUploader

  def name
    @name ||= truncate(File.basename(self.audio.url), :length => 50)
  end
end
