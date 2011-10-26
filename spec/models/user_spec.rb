require 'spec_helper'

describe User do
  before :each do
    @user = User.make! 
  end

  it "rejects invalid username" do
    [ "got some spaces", "gotsome$^/>", "tim" ].each { |uname|
      expect { User.make!(:username => uname) }.to raise_error(ActiveRecord::RecordInvalid, /username/i)
    }
  end

  it "accepts valid username" do
    [ "testuser", "new.user35", "35test.users." ].each { |uname|
      expect { User.make!(:username => uname) }.not_to raise_error
    }
  end

  it "has a unique username" do
    expect { 
      User.make!(:username => "jimmy")
      User.make!(:username => "jimmy")
    }.to raise_error(ActiveRecord::RecordInvalid, /username/i)
  end

  describe "borrowing" do
    it "borrows samples" do
      s = Sample.make!
      expect { @user.borrow!(s) }.to change(SampleBorrow, :count).by(1)
    end

    it "only borrows samples once" do
      s = Sample.make!
      @user.borrow!(s)
      expect { @user.borrow!(s) }.to raise_error(ActiveRecord::RecordNotUnique, /sample/i)
    end

    it "unborrows samples" do
      s = Sample.make!
      @user.borrow!(s)
      expect { @user.unborrow!(s) }.to change(SampleBorrow, :count).by(-1)
    end

    it "has borrowing? method" do
      s = Sample.make! 
      @user.borrow!(s)
      @user.should be_borrowing(s)
    end
  end
end
