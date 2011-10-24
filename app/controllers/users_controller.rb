class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
    @samples_presenter = Samples::IndexPresenter.new(@user)
    @beats_presenter = Beats::IndexPresenter.new(@user)
  end

  def index
    @users = User.all
  end
end
