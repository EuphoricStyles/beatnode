class PagesController < ApplicationController

  def home
    redirect_to(welcome_path, {:notice => flash[:notice], :alert => flash[:alert]}) unless user_signed_in?
  end

  def welcome
  end
end
