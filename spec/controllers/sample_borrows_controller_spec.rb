require 'spec_helper'

describe SampleBorrowsController do
  before :each do
    @user = User.make!
    sign_in(@user)
    @sample = Sample.make!
    @attr = { :sample_id => @sample.id }
  end

  describe 'POST create' do
    it 'assigns @sample' do
      post :create, :sample_borrow => @attr
      assigns[:sample].should == @sample
    end

    it 'creates a new sample_borrow' do
      expect { post :create, :sample_borrow => @attr }.to change(SampleBorrow, :count).by(1)
    end

    it 'redirects to show with html format request' do
      post :create, :format => :html, :sample_borrow => @attr
      response.should redirect_to(:controller => :samples, :action => :show, :id => @sample.id)
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @user.borrow!(@sample)
      @borrow = @user.sample_borrows.find_by_sample_id(@sample.id)
    end

    it 'assigns @sample' do
      delete :destroy, :id => @borrow.id
      assigns[:sample].should eq(@borrow.sample)
    end

    it 'destroys borrow' do
      expect { delete :destroy, :id => @borrow.id }.to change(SampleBorrow, :count).by(-1)
    end
  end
end
