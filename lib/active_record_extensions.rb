module ActiveRecordExtensions
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    # macro that adds the :from_users_watched_by class method
    def include_in_feed
      
      # Sample.from_users_watched_by(user) returns all the samples from the users 'user' is watching
      instance_eval do
        def from_users_watched_by(user)
          watching_ids = "SELECT watched_id FROM user_relationships WHERE watcher_id = :user_id"
          where("user_id IN (#{watching_ids}) OR user_id = :user_id", {:user_id => user.id})
        end
      end

    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtensions)
