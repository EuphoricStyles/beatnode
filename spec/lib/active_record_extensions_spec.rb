require 'spec_helper'

describe ActiveRecordExtensions do
  before :all do
    TestModel = Class.new
    TestModel.send(:include, ActiveRecordExtensions)
    TestModel.send(:include_in_feed)
  end

  describe '.include_in_feed' do
    it 'adds the :from_users_watched_by class method' do
      TestModel.should respond_to :from_users_watched_by
    end
  end

  describe '.from_users_watched_by' do
    before :each do
      @user = User.make!
      5.times { @user.watch!(User.make!) }

      @beat = Beat.make! :user => @user.watching[0]
      @sample = Sample.make! :user => @user.watching[1]
      @sample_borrow = @user.watching[2].sample_borrows.create! :sample_id => @sample.id
    end

    it 'returns samples belonging to watched users' do
      Sample.from_users_watched_by(@user).should eq([@sample])
    end

    it 'returns beats belonging to watched users' do
      Beat.from_users_watched_by(@user).should eq([@beat])
    end

    it 'returns sample borrows belonging to watched users' do
      SampleBorrow.from_users_watched_by(@user).should eq([@sample_borrow])
    end

    it 'doesnt affect other models' do
      SampleUse.should_not respond_to(:from_users_watched_by)
      User.should_not respond_to(:from_users_watched_by)
    end
  end
end
