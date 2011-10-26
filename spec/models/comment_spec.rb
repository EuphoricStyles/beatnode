require 'spec_helper'

describe Comment do
  before :each do
    @comment = Comment.make! 
  end

  it "has a body" do
    @comment.should respond_to :body
  end

  it "is polymorphic" do
    [ Beat.new, Sample.new ].each { |c| c.should respond_to :comments }
  end

  it "validates length" do
    Comment.new(:body => 'a'*201).should_not be_valid
    Comment.new(:body => 'a'*200).should be_valid
  end
end
