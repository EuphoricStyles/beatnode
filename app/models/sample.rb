class Sample < ActiveRecord::Base
  default_scope order('created_at desc')

  attr_accessible :description, :audio

  #mount_uploader :audio, AudioUploader
  has_one :audio_component, :as => :owner, :dependent => :destroy
  accepts_nested_attributes_for :audio_component

  belongs_to :user

  has_many :sample_borrows
  has_many :borrowers, :through => :sample_borrows, :source => :user

  has_many :sample_uses
  has_many :beats, :through => :sample_uses

  has_many :comments, :as => :commentable

  has_one :feed_event, :as => :subject, :dependent => :destroy
  after_save :create_feed_event
  
  validates_length_of :description, :maximum => 200, :too_long => "That description is too long!"

  #validates :audio, :presence => true, :file_size => { :maximum => 5.megabytes }

  acts_as_taggable

  def self.sampled_by(beat)
    sample_ids = "SELECT sample_id from sample_uses WHERE beat_id = #{beat.id}"
    where("id in (#{sample_ids})")
  end

  def name
    audio_component.display_name
  end
end
