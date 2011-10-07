require 'spec_helper'

describe SampleUse do
  before :each do
    @user = User.make! :username => "beatmaker"
    @user.samples.build :title => "DOLLA BILLS YALL"
  end

  it "is created by a user" do
    @user.samples.first.title.should == "DOLLA BILLS YALL"
  end
end
