class FeedEventsController < ApplicationController
  def index
    @feed = FeedEvent.from_users_watched_by(current_user)
  end
end
