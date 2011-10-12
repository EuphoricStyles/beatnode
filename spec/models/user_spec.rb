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

  describe "sample relationship" do
    it "creates samples" do
      @user.samples.create(:name => "s1")
      @user.samples.first.name.should == "s1"
    end

    it "borrows samples" do
      s = Sample.make! :name => "new sample"
      @user.borrow!(s)
      @user.borrowed_samples.first.should == s

      expect { @user.borrow!(s) }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "unborrows samples" do
      s = Sample.make! :name => "sample"
      @user.borrow!(s)
      @user.should be_borrowing(s)
      @user.unborrow!(s)
      @user.should_not be_borrowing(s)
    end

    it "has borrowing? method" do
      s = Sample.make! :name => "borrow"
      @user.borrow!(s)
      @user.should be_borrowing(s)
    end
  end
end
