module Samples
  class IndexPresenter
    extend ActiveSupport::Memoizable

    def initialize(user)
      @user = user
    end

    def all_samples
      (@user.samples + @user.borrowed_samples)
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
