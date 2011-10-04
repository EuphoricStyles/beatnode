class Beat < ActiveRecord::Base
  has_attached_file :audio
  validates_attachment_presence :audio
  validates_attachment_size :audio, :less_than => 5.megabytes, :message => "File can't exceed 10Mb."
  validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                                          :message => 'Not a valid mp3 file.'

  belongs_to :user
end
