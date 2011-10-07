require 'file_size_validator' 

class Sample < ActiveRecord::Base
  attr_accessible :title, :description, :audio

  mount_uploader :audio, AudioUploader

  belongs_to :user

  has_many :sample_borrows
  has_many :borrowers, :through => :sample_borrows, :class_name => "User", :foreign_key => "user_id"

  has_many :sample_uses
  has_many :beats, :through => :sample_uses
  
  validates_length_of :title, :maximum => 75, :too_long => "That title is too long!"
  validates_length_of :description, :maximum => 150, :too_long => "That description is too long!"

  validates :audio, :presence => true, :file_size => { :maximum => 5.megabytes }
end
