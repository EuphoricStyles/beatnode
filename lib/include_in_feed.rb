module ActiveRecordExtensions
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def include_in_feed
      instance_eval <<-EOS
        def from_watching(user)
          user.watching.map(&:#{self.to_s.tableize}).flatten!
        end
      EOS
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecordExtensions)
