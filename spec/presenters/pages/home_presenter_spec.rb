require 'spec_helper'

describe Pages::HomePresenter do
  before :each do
    @user = User.make!
    @watched = User.make!
    @user.watch!(@watched)
    @presenter = Pages::HomePresenter.new(@user)
  end

  describe '#feed' do
    it 'responds to :feed' do
      @presenter.should respond_to :feed
    end

    it 'returns the beats posted by watched users' do
      beat = Beat.make! :user_id => @watched.id
      @presenter.feed.should eq([beat])
    end

    it 'returns the samples posted by watched users' do
      sample = Sample.make! :user_id => @watched.id
      @presenter.feed.should eq([sample])
    end

    it 'returns sample borrows from watched users' do
      sample = Sample.make!
      sb = SampleBorrow.make! :user_id => @watched, :sample_id => sample.id
      @presenter.feed.should eq([sb])
    end

    describe ':only parameter' do
      it 'only returns specified objects' do
        sample = Sample.make! :user_id => @watched
        beat = Beat.make! :user_id => @watched
        @presenter.feed(:only => [:samples]).should eq([sample])
      end
    end
  end
end
