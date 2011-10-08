require 'spec_helper'

describe SampleBorrow do
  before :each do
    @borrower = User.make! :username => "Borrower"
    @borrower.borrowed_samples.build :name => "Sample Dample"
  end

  it "gets borrowed by users" do
    @borrower.borrowed_samples.first.name.should == "Sample Dample"
  end
end
