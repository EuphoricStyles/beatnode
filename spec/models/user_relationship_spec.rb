require 'spec_helper'

describe UserRelationship do
  before :each do
    @user = User.make! :username => 'alejandro'
    @other = User.make! :username => 'otheruser'
    @relationship = @user.user_relationships.build(:watched_id => @other.id)
  end

  it "adds a relationship" do
    expect { @relationship.save }.to change(UserRelationship, :count).by(1)
  end

  it "has a watcher" do
    @relationship.watcher.should == @user
  end

  it "has a watched" do
    @relationship.watched.should == @other
  end

  it "watches other users" do
    @user.watch!(u = User.make!(:username => 'watchme'))
    @user.should be_watching(u)
  end
end
