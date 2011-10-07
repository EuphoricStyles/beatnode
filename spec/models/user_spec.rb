require 'spec_helper'

describe User do
  before :each do
    @user = User.make! 
  end

  it "has a valid username" do
    [ "got some spaces", "gotsome$^/>", "tim" ].each { |uname|
      expect { User.make!(:username => uname) }.to raise_error(ActiveRecord::RecordInvalid)
    }
  end

  it "checks for username uniqueness" do
    expect { 
      User.make!(:username => "jimmy")
      User.make!(:username => "jimmy")
    }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
