class SamplesController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @sample = Sample.find(params[:id])
    @beats = Beat.which_sample(@sample).limit(10)
  end

  def new
    @sample = current_user.samples.new
  end

  def create
    @sample = current_user.samples.build(params[:sample])
    
    if @sample.save
      flash[:success] = "Sample uploaded!"
      redirect_to sample_path @sample
    else
      render :new
    end
  end

  def index
    @presenter = ::Samples::IndexPresenter.new(current_user)
  end

  def download
    @sample = Sample.find(params[:id])
    send_file(@sample.audio_component.audio.path, :filetype => @sample.audio_component.filetype)
  end
end
