require 'spec_helper'

describe SampleBorrow do
  before :each do
    @user = User.make!
    @watched = User.make!
    @user.watch!(@watched)
    @sample = Sample.make!

    @sb = @watched.sample_borrows.build(:sample_id => @sample.id)
  end

  it 'is valid' do
    @sb.save!
  end

  describe '.from_watching' do
    before :each do
      @sb.save
    end

    it 'is a class method' do
      SampleBorrow.should respond_to :from_watching
    end

    it 'returns sample borrows from watching' do
      SampleBorrow.from_watching(@user).should == [ @sb ]
    end
  end
end
