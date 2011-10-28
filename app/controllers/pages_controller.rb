class PagesController < ApplicationController

  def home
    if user_signed_in?
      #@presenter = ::Pages::HomePresenter.new(current_user)
    else
      redirect_to(welcome_path, {:notice => flash[:notice], :alert => flash[:alert]})
    end
  end

  def welcome
  end
end
