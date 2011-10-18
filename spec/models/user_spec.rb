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

  describe "sample relationships" do
    it "creates samples" do
      expect { @user.samples.create }.to change(@user.samples, :size).by(1)
    end

    it "borrows samples" do
      s = Sample.make!
      @user.borrow!(s)

      expect { @user.borrow!(s) }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "unborrows samples" do
      s = Sample.make!
      @user.borrow!(s)
      @user.should be_borrowing(s)
      @user.unborrow!(s)
      @user.should_not be_borrowing(s)
    end

    it "has borrowing? method" do
      s = Sample.make! 
      @user.borrow!(s)
      @user.should be_borrowing(s)
    end
  end
end
