require 'spec_helper'

describe UsersController do
  before :each do
    @user = User.make!
    @other = User.make! :username => 'jimmy'
    sign_in @user
  end

  describe 'GET show' do
    before :each do
      get :show, :id => @other
    end

    it 'assigns @user' do
      assigns[:user].should == @other
    end
  end

  describe 'GET index' do
    before :each do
      get :index
    end
  end
end
