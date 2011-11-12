class AudioComponentsController < ApplicationController
  before_filter :authenticate_user!

  def download
    @ac = AudioComponent.find(params[:id])

    if @ac
      send_file(@ac.audio.path, :type => @ac.content_type)
    else
      redirect_to root_path, :alert => "Couldn't download file."
    end
  end
end
