class SamplesController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @sample = Sample.find(params[:id])
  end

  def new
    @sample = current_user.samples.new
  end

  def create
    @sample = current_user.samples.build(params[:sample])
    
    if @sample.save
      flash[:notice] = "Sample uploaded!"
      redirect_to sample_path @sample
    else
      render :new
    end
  end

#  def index
#    @owned_samples = current_user.samples
#    @borrowed_samples = current_user.borrowed_samples
#  end
end
