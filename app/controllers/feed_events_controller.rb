class FeedEventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @feed = FeedEvent.from_users_watched_by(current_user).limit(10)
  end
end
