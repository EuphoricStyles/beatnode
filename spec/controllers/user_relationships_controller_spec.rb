require 'spec_helper'

describe UserRelationshipsController do
  before :each do
    @user = User.make!
    @other = User.make!
    sign_in @user
  end

  describe 'POST create' do
    it 'assigns @user' do
      post :create, :user_relationship => {:watched_id => @other}
      assigns[:user].should eq(@other)
    end

    it 'creates relationship' do
      expect { post :create, :user_relationship => {:watched_id => @other} }.to change(UserRelationship, :count).by(1)
    end

    it 'redirects to show with html format request' do
      post :create, :format => :html, :user_relationship => {:watched_id => @other}
      response.should redirect_to(:controller => :users, :action => :show, :id => @other.id)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      post :create, :user_relationship => {:watched_id => @other}
      @rel = UserRelationship.find_by_watched_id_and_watcher_id(@other.id, @user.id)
    end

    it 'assigns @user' do
      delete :destroy, :id => @rel
      assigns[:user].should eq(@other)
    end

    it 'destroys relationship' do
      expect { delete :destroy, :id => @rel }.to change(UserRelationship, :count).by(-1)
    end
  end
end
