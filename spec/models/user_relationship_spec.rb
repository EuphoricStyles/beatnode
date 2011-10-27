require 'spec_helper'

describe UserRelationship do
  before :each do
    @user = User.make!
    @other = User.make!
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
end
