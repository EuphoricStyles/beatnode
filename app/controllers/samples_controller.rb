class SamplesController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create, :destroy ]
  
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
      redirect_to root_path
    else
      render :new
    end
  end
end
