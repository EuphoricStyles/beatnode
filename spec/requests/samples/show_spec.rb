require 'spec_helper'

describe "show samples" do
  before :each do
    @sample = Sample.make! :name => "test sample", :description => "test description"
    @user = User.make!
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
  end

  it "shows the name and description" do
    visit "/samples/1"
    page.should have_content "test sample"
    page.should have_content "test description"
  end

  it "has a grab link" do
    visit sample_path(@sample)
    page.should have_button "Grab"
  end
end
