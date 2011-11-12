class SampleBorrowsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @sample = Sample.find(params[:sample_borrow][:sample_id])
    current_user.borrow!(@sample)
    respond_to do |format|
      format.html { redirect_to @sample }
      format.js
    end
  end

  def destroy
    @sample = SampleBorrow.find(params[:id]).sample
    current_user.unborrow!(@sample)
    respond_to do |format|
      format.html { redirect_to @sample }
      format.js
    end
  end

end
