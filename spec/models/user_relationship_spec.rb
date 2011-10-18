require 'spec_helper'

describe UserRelationship do
  before :each do
    @user = User.make! :username => 'alejandro'
    @other = User.make! :username => 'other'
    @relationship = @user.user_relationships.build :watched_id => @other.id
  end

  it "should be valid" do
    @relationship.save!
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
