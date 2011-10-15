require 'spec_helper'

describe "home page" do
  before :each do
    @user = User.make! :username => "testuser", :email => "test@example.com"
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
  end

  it "shows user if user signed in" do
    page.should have_content "Home for testuser"
  end

  it "redirects to sign_in page if no one signed in" do
    visit "/"
    page.should have_content "Sign in"
  end

  it "has link to homepage" do
    page.should have_link "Home"
    click_link "Home"
    current_path.should == root_path
  end

  it "links to new sample form" do
    click_link "Upload a sample"
    page.should have_content "Upload a new sample"
  end

  it "says if user doesn't have a bio" do
    page.should have_content "You haven't added a bio yet"
  end
end
