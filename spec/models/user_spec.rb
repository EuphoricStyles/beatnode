require 'spec_helper'

describe User do
  before :each do
    @user = User.make! :email => "test@test.com"
  end

  it "has a name" do
    @user.email.should == "test@test.com"
  end
end
