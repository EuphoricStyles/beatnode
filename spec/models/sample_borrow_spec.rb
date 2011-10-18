require 'spec_helper'

describe SampleBorrow do
  before :each do
    @user = User.make! :username => 'bobby'
    @sample = Sample.make! :user => User.make!
    @sb = @user.sample_borrows.build(:sample_id => @sample.id)
    @sb.save!
  end

  it 'has a borrowing? method' do
    @user.should be_borrowing @sample
    @user.should_not be_borrowing Sample.make!
  end

  it 'has a borrow! method' do
    newsample = Sample.make! :user => User.make!
    @user.borrow!(newsample)
    @user.should be_borrowing newsample
  end
end
