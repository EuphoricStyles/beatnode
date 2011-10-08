class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def index
    @users = User.all
  end
end
