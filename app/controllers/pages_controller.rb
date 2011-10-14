class PagesController < ApplicationController

  def home
    unless user_signed_in?
      redirect_to welcome_path, :notice => flash[:notice], :alert => flash[:alert]
    end
  end

  def welcome
  end
end
