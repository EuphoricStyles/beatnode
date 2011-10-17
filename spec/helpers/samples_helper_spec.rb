require 'spec_helper'

describe SamplesHelper do
  describe '#sample_owned_or_borrowed_timestamp' do
    before :each do
      @user1 = User.make! :username => 'creator'
      @sample = Sample.make! :user => @user1
      @user2 = User.make! :username => 'grabber'
    end

    it 'formats uploaded samples' do
      sample_owned_or_borrowed_timestamp(@user1, @sample).should =~ /^Uploaded/
    end

    it 'formats borrowed samples' do
      @user2.borrow!(@sample)
      sample_owned_or_borrowed_timestamp(@user2, @sample).should =~ /^Grabbed from creator/
    end
  end
end
