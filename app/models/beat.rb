require 'file_size_validator' 

class Beat < ActiveRecord::Base
  attr_accessible :title, :description, :audio

  mount_uploader :audio, AudioUploader

  belongs_to :creator, :class_name => "User"
  has_and_belongs_to_many :samples
  
  validates_presence_of :title
  validates_length_of :title, :maximum => 75, :too_long => "That title is too long!"
  validates_length_of :description, :maximum => 150, :too_long => "That description is too long!"

  validates :audio, :presence => true, :file_size => { :maximum => 10.megabytes }
end
