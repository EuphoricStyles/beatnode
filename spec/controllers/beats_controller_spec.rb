require 'spec_helper'

describe BeatsController do
  render_views

  let(:beat) { mock_model(Beat) }

  before :each do
    @user = User.make!
    sign_in @user
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
    before :each do
      Beat.stub!(:new).and_return(beat)

      @beat_attr = {
        :name => 'Beat name', 
        :description => 'Beat description',
        :audio => open("#{Rails.root}/data/audio/rickyrice.mp3")
      }
    end

    context 'when beat saves successfully' do
      before :each do
        beat.stub(:save).and_return(true)
      end

      it 'creates a new beat with given attributes' do
        Beat.should_receive(:new).and_return(beat)
        post :create, :beat => @beat_attr
      end

      it 'saves the beat' do
        beat.should_receive(:save)
        post :create, :beat => @beat_attr
      end

      it 'redirects to show page' do
        post :create, :beat => @beat_attr
        response.should redirect_to(:action => 'show', :id => beat.id)
      end
    end

    context 'when beat fails to save' do
      before :each do
        beat.stub(:save).and_return(false)
      end

      it 'renders the new template' do
        beat.should_receive(:name)
        beat.should_receive(:description)
        post :create
        response.should render_template(:new)
      end
    end
  end

  describe 'GET show' do
    before :each do
      @beat = Beat.make!
    end

    it 'assigns @beat' do
      get :show, :id => @beat.id
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
