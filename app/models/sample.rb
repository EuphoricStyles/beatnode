require 'file_size_validator' 

class Sample < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :description, :audio

  mount_uploader :audio, AudioUploader

  belongs_to :user

  has_many :sample_borrows
  has_many :borrowers, :through => :sample_borrows, :source => :user

  has_many :sample_uses
  has_many :beats, :through => :sample_uses

  has_many :comments, :as => :commentable
  
  validates_length_of :description, :maximum => 600, :too_long => "That description is too long!"

  validates :audio, :presence => true, :file_size => { :maximum => 5.megabytes }

  acts_as_taggable

  def name
    @name ||= truncate(File.basename(self.audio.url), :length => 50)
  end
end
