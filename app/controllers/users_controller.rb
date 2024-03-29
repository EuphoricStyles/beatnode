class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @samples_presenter = Samples::IndexPresenter.new(@user)
    @beats_presenter = Beats::IndexPresenter.new(@user)
    @feed = @user.feed_events.limit(10)
  end

  def index
    @users = User.all.limit(10)
  end
end
