class PagesController < ApplicationController

  def home
    if user_signed_in?
      @samples = (current_user.samples + current_user.borrowed_samples).sort_by { |s| s.created_at }
    else
      redirect_to welcome_path, :notice => flash[:notice], :alert => flash[:alert]
    end
  end

  def welcome
  end
end
