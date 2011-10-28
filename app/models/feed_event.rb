class FeedEvent < ActiveRecord::Base
  belongs_to :feedable, :polymorphic => true
  belongs_to :user

  default_scope :order => 'created_at DESC'
  scope :from_users_watched_by, lambda { |user| watched_by(user) }

  private

  def self.watched_by(user)
    watching_ids = %( SELECT watched_id FROM user_relationships WHERE watcher_id = :user_id )
    feed_ids = %( SELECT id FROM feed_events WHERE user_id IN (#{watching_ids}) OR user_id = :user_id )
    where("id IN (#{feed_ids})", {:user_id => user.id})
  end
end
