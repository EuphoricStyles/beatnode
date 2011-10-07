require 'spec_helper'

describe Comment do
  before :each do
    @comment = Comment.make! 
  end

  it "has a body" do
    @comment.should respond_to :body
  end

  it "preserves whitespace" do
    b = <<-EOB
Test comment.

Many lines.

   weird whitespace!
    EOB
    com = Comment.make! :body => b
    com.body.should == b
  end

  it "is polymorphic" do
    [ Beat.new, Sample.new ].each { |c| c.should respond_to :comments }
  end
end
