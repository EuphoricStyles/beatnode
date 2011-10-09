class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_id])
  end

  def index
    @users = User.all
  end

  protected

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
end
