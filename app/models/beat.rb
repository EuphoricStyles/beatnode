class Beat < ActiveRecord::Base
  attr_accessible :title, :description

  belongs_to :creator, :class_name => "User"
  has_and_belongs_to_many :samples, :unique => true
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 75, :too_long => "That title is too long!"
  
  validates_length_of :description, :maximum => 150, :too_long => "That description is too long!"

  has_attached_file :audio
  validates_attachment_presence :audio
  validates_attachment_size :audio, :less_than => 10.megabytes, :message => "File size can't exceed 10Mb."
  validates_attachment_content_type :mp3, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                                          :message => 'Not a valid mp3 file.'
end
