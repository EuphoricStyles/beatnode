module Samples
  class IndexPresenter
    extend ActiveSupport::Memoizable

    def initialize(user)
      @user = user
    end

    def all_samples
      sample_ids = %(SELECT id FROM samples WHERE user_id = :user_id)
      borrow_ids = %(SELECT sample_id FROM sample_borrows WHERE user_id = :user_id)
      Sample.where("id IN (#{sample_ids}) OR id IN (#{borrow_ids})", :user_id => @user.id).limit(10)
    end
    memoize :all_samples

    def uploaded_samples
      @user.samples.limit(10)
    end
    memoize :uploaded_samples

    def borrowed_samples
      @user.borrowed_samples.limit(10)
    end
    memoize :borrowed_samples
  end
end
