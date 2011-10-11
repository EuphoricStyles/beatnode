require 'spec_helper'

describe "show samples" do
  before :each do
    @sample = Sample.make! :name => "test sample", :description => "test description"
  end

  it "shows the name and description" do
    visit "/samples/1"
    page.should have_content "test sample"
    page.should have_content "test description"
  end
end
