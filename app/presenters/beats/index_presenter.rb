module Beats
  class IndexPresenter
    extend ActiveSupport::Memoizable

    def initialize(user)
      @user = user
    end

    def all_beats
      @user.beats.limit(10)
    end
    memoize :all_beats
  end
end
