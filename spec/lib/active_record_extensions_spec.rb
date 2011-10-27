require 'spec_helper'

class TestModel
  include ActiveRecordExtensions
  include_in_feed
end

describe ActiveRecordExtensions do
  describe '.include_in_feed' do
    it 'adds the :from_following class method' do
      TestModel.should respond_to :from_watching
    end
  end

  describe '.from_watching' do
    before :each do
      @user = User.make!
      5.times { @user.watch!(User.make!) }

      @beat = Beat.make! :user => @user.watching[0]
      @sample = Sample.make! :user => @user.watching[1]
      @sample_borrow = @user.watching[2].sample_borrows.create! :sample_id => @sample.id
    end

    it 'returns samples belonging to watched users' do
      Sample.from_watching(@user).should eq([@sample])
    end

    it 'returns beats belonging to watched users' do
      Beat.from_watching(@user).should eq([@beat])
    end

    it 'returns sample borrows belonging to watched users' do
      SampleBorrow.from_watching(@user).should eq([@sample_borrow])
    end
  end
end
