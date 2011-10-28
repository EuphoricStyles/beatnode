class FeedEventsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @feed = FeedEvent.all
  end
end
