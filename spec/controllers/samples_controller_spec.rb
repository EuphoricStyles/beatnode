require 'spec_helper'

describe SamplesController do
  render_views

  before :each do
    @user = User.make!
    sign_in(@user)

    @sample = Sample.make!
  end

  describe 'GET new' do
    before :each do
      get :new
    end

    it 'is successful' do
      response.should be_successful
    end

    it 'renders the new sample form' do
      response.body.should have_selector('form.new_sample')
    end
  end

  describe 'POST create' do
    context 'when sample is valid' do
      before :each do
        Sample.stub!(:new).and_return(@sample)
        @sample.stub!(:save).and_return(true)
      end

      it 'redirects to show page' do
        post :create
        response.should redirect_to(:action => :show, :id => @sample)
      end

      it 'sets flash[:success]' do
        post :create
        flash[:success].should =~ /uploaded/i
      end
    end

    context 'when beat fails to save' do
      before :each do
        @invalid = { :name => '', :description => '', :audio => '' }
      end

      it 'renders the new template' do
        post :create, :sample => @invalid
        response.should render_template(:new)
      end
    end
  end

  describe 'GET show' do
    it 'assigns @beat' do
      get :show, :id => @sample
      assigns[:sample].should be_eql(@sample)
    end
  end

  describe 'GET index' do
    before :each do
      10.times {|i| Sample.make! :description => "#{i}", :user => @user}
    end

    it 'assigns @presenter' do
      get :index
      assigns[:presenter].should be_kind_of(Samples::IndexPresenter)
    end
  end
end
