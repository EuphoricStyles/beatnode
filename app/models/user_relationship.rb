class UserRelationship < ActiveRecord::Base
  attr_accessible :watched_id

  belongs_to :watched, :class_name => 'User'
  belongs_to :watcher, :class_name => 'User'

  validates_presence_of :watched_id
  validates_presence_of :watcher_id
end
