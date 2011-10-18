class UserRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_relationship][:watched_id])
    current_user.watch!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id]).watched
    current_user.unwatch!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
