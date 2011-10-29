require 'spec_helper'

describe FeedEvent do
  before :each do
    @event = FeedEvent.make!
  end

  it 'has a subject_id' do
    @event.should respond_to(:subject_id)
  end

  it 'has a subject_type' do
    @event.should respond_to(:subject_type)
  end

  it 'validates uniqueness' do
    FeedEvent.make! :subject_id => 1, :subject_type => 'Sample'
    expect { FeedEvent.create! :subject_id => 1, :subject_type => 'Sample' }.to raise_error(ActiveRecord::RecordNotUnique)
  end

  describe '.from_users_watched_by' do
    before :each do
      @watched = User.make!
      @sample = Sample.make! :user => @watched
      @beat1 = Beat.make! :user => @watched
      @unwatched = User.make!
      @beat2 = Beat.make! :user => @unwatched

      @user = User.make!
      @user.watch!(@watched)

      @from_watched = FeedEvent.from_users_watched_by(@user)
    end

    it 'returns samples uploaded from watched users' do
      @from_watched.map(&:subject_id).map { |s| Sample.find(s) rescue nil }.should include(@sample)
    end

    it 'returns beats uploaded from watched users' do
      @from_watched.map(&:subject_id).map { |b| Beat.find(b) rescue nil }.should include(@beat1)
    end

    it 'only returns subjects from followed users' do
      @from_watched.should_not include(@beat2)
      @from_watched.map(&:subject_id).map { |b| Beat.find(b) rescue nil }.should_not include(@beat2)
    end
  end
end
