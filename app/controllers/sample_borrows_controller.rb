class SampleBorrowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    sample = Sample.find(params[:sample_borrow][:sample_id])
    current_user.borrow!(sample)
    redirect_to root_path
  end

  def destroy
  end

end
