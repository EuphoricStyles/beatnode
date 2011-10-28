require 'spec_helper'

describe FeedEventsController do
  describe 'GET index' do
    before :each do
      @user = User.make!
      sign_in(@user)
      @other = User.make!

      @beat = Beat.make! :user => @user
      @sample = Sample.make! :user => @other

      get :index
    end

    it 'is successful' do
      response.should be_successful
    end

    it 'assigns @feed' do
      assigns[:feed].should_not be_nil
    end
  end
end
