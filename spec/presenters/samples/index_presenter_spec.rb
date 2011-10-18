require 'spec_helper'

describe Samples::IndexPresenter do
  before :each do
    @user = User.make!
    10.times { |i| Sample.make!(:user => @user, :description => i.to_s, :created_at => Time.now + (i*10).minutes) }
    @presenter = Samples::IndexPresenter.new(@user)
  end

  it 'sorts by created at date' do
    @presenter.all_samples.first.description.should == "9"
    @presenter.uploaded_samples.first.description.should == "9"
  end

  it 'has borrowed samples' do
    s = Sample.make! 
    @user.borrow! s
    @presenter.borrowed_samples.first.should == s
  end
end
