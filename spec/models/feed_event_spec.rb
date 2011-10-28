require 'spec_helper'

describe FeedEvent do
  before :each do
    @event = FeedEvent.make!
  end

  it 'has a feedable_id' do
    @event.should respond_to(:feedable_id)
  end

  it 'has a feedable_type' do
    @event.should respond_to(:feedable_type)
  end

  it 'validates uniqueness' do
    FeedEvent.make! :feedable_id => 1, :feedable_type => 'Sample'
    expect { FeedEvent.create! :feedable_id => 1, :feedable_type => 'Sample' }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  describe '.from_users_watched_by' do
    before :each do
      @watched = User.make!
      @sample = Sample.make! :user => @watched
      @unwatched = User.make!
      @beat = Beat.make! :user => @unwatched

      @user = User.make!
      @user.watch!(@watched)

      @from_watched = FeedEvent.from_users_watched_by(@user)
    end

    it 'returns events from watched users' do
      @from_watched.first.feedable_type.should == 'Sample'
      @from_watched.first.feedable_id.should == @sample.id
    end
  end
end
