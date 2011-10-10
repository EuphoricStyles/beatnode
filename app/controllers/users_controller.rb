class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
  end

  def index
    @users = User.all
  end
end
