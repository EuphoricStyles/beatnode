class PagesController < ApplicationController

  def home
    if user_signed_in?
      @feed = FeedEvent.all
    else
      redirect_to(welcome_path, {:notice => flash[:notice], :alert => flash[:alert]})
    end
  end

  def welcome
  end
end
