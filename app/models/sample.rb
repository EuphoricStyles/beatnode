class Sample < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  default_scope order('created_at desc')

  attr_accessible :description, :audio

  mount_uploader :audio, AudioUploader

  belongs_to :user

  has_many :sample_borrows
  has_many :borrowers, :through => :sample_borrows, :source => :user

  has_many :sample_uses
  has_many :beats, :through => :sample_uses

  has_many :comments, :as => :commentable

  has_one :feed_event, :as => :subject, :dependent => :destroy
  after_save :create_feed_event
  
  validates_length_of :description, :maximum => 200, :too_long => "That description is too long!"

  validates :audio, :presence => true, :file_size => { :maximum => 5.megabytes }

  acts_as_taggable

  def name
    @name ||= truncate(File.basename(self.audio.url), :length => 50)
  end
end
