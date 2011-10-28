require 'spec_helper'

describe BeatsController do
  render_views

  before :each do
    @user = User.make!
    sign_in(@user)

    @beat = Beat.make!
  end

  describe 'GET new' do
    before :each do
      get :new
    end

    it 'is successful' do
      response.should be_successful
    end

    it 'renders the new beat form' do
      response.body.should have_selector('form.new_beat')
    end
  end

  describe 'POST create' do
    context 'when beat is valid' do
      before :each do
        Beat.stub!(:new).and_return(@beat)
        @beat.stub!(:save).and_return(true)
      end

      it 'redirects to show page' do
        post :create
        response.should redirect_to(:action => :show, :id => @beat)
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
        post :create, :beat => @invalid
        response.should render_template(:new)
      end
    end
  end

  describe 'GET show' do
    it 'assigns @beat' do
      get :show, :id => @beat
      assigns[:beat].should be_eql(@beat)
    end
  end

  describe 'GET index' do
    before :each do
      10.times {|i| Beat.make! :name => "#{i}", :user => @user}
    end

    it 'assigns @presenter' do
      get :index
      assigns[:presenter].should be_kind_of(Beats::IndexPresenter)
    end
  end
end
