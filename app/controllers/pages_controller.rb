class PagesController < ApplicationController
  #before_filter :authenticate_user!, :except => :about

  def home
    render :welcome unless user_signed_in?
  end

  def welcome
  end
end
