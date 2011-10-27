module ActiveRecordExtensions
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    # macro that adds the :from_watching class method
    def include_in_feed
      instance_eval do

        # Sample.from_watching(user) returns all the samples from the users 'user' is watching
        def from_watching(user)
          watching_ids = "SELECT watched_id FROM user_relationships WHERE watcher_id = :user_id"
          where("user_id IN (#{watching_ids}) OR user_id = :user_id", {:user_id => user.id})
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtensions)
