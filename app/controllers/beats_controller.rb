class BeatsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @beat = Beat.find(params[:id])
  end

  def new
    @beat = Beat.new
  end

  def create
    @beat = Beat.new(params[:beat])

    if @beat.save
      flash[:success] = 'Beat uploaded!'
      redirect_to beat_path(@beat)
    else
      render :new
    end
  end

  def index
    @presenter = ::Beats::IndexPresenter.new(current_user)
  end
end
