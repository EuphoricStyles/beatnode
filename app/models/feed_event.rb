class FeedEvent < ActiveRecord::Base
  belongs_to :subject, :polymorphic => true
  belongs_to :user

  default_scope :order => 'created_at DESC'
  scope :from_users_watched_by, lambda { |user| watched_by(user) }

  before_save :assign_user_id

  def get_subject
    self.subject_type.constantize.find(self.subject_id)
  end

  private

  def self.watched_by(user)
    watched_ids = "SELECT watched_id FROM user_relationships WHERE watcher_id = :user_id"
    where("user_id IN (#{watched_ids}) OR user_id = :user_id", :user_id => user.id)
  end

  def assign_user_id
    self.user_id ||= get_subject.user_id rescue nil
  end
end
