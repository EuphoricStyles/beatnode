class PagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to user_show_path(current_user.username)
    else
      redirect_to sign_in_path
    end
  end

end
