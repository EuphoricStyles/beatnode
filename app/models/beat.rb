class Beat < ActiveRecord::Base
  attr_accessible :name, :description, :audio

  default_scope order('created_at desc')

  #mount_uploader :audio, AudioUploader
  has_one :audio_component, :as => :owner

  belongs_to :user

  has_many :sample_uses
  has_many :samples, :through => :sample_uses

  has_many :comments, :as => :commentable

  has_one :feed_event, :as => :subject, :dependent => :destroy
  after_save :create_feed_event
  
  validates_presence_of :name
  validates_length_of :name, :maximum => 75, :too_long => "That name is too long!"
  validates_length_of :description, :maximum => 200, :too_long => "That description is too long!"

  #validates :audio, :presence => true, :file_size => { :maximum => 10.megabytes }

  acts_as_taggable

  def self.which_sample(sample)
    beat_ids = "SELECT beat_id FROM sample_uses WHERE sample_id = #{sample.id}"
    where("id in (#{beat_ids})")
  end
end
