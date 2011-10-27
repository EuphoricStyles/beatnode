module Pages
  class HomePresenter
    extend ActiveSupport::Memoizable

    def initialize(user)
      @user = user
    end

    def feed(options = {})
      models = options[:only].is_a?(Array) ? options[:only] : [:samples, :beats, :sample_borrows]

      feed = []
      feed << Sample.from_users_watched_by(@user) if models.include?(:samples)
      feed << Beat.from_users_watched_by(@user) if models.include?(:beats)
      feed << SampleBorrow.from_users_watched_by(@user) if models.include?(:sample_borrows)
      feed.flatten!
    end
    memoize :feed
  end
end
