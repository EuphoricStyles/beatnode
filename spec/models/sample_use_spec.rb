require 'spec_helper'

describe SampleUse do
  before :each do
    @user = User.make! :username => "beatmaker"
    @user.samples.build :name => "DOLLA BILLS YALL"
  end

  it "is created by a user" do
    @user.samples.first.name.should == "DOLLA BILLS YALL"
  end
end
