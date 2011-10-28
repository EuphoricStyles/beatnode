class SampleBorrow < ActiveRecord::Base
  attr_accessible :sample_id

  default_scope order('created_at desc')

  belongs_to :sample
  belongs_to :user

  has_many :comments, :as => :commentable

  has_one :feed_event, :as => :feedable, :dependent => :destroy
  after_save :create_feed_event

  validates_presence_of :sample_id
  validates_presence_of :user_id
end
