require 'spec_helper'

describe "home page" do
  before :each do
    @user = User.make! :username => "testuser", :email => "test@example.com"
    @sign_in_user = lambda { |user|
      visit new_user_session_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
    }
  end

  it "shows user if user signed in" do
    @sign_in_user.call(@user)
    page.should have_content "Home for testuser"
  end

  it "redirects to sign_in page if no one signed in" do
    visit "/"
    page.should have_content "Sign in"
  end

  it "has link to homepage" do
    @sign_in_user.call(@user)
    page.should have_link "Home"
    click_link "Home"
    current_path.should == "/"
  end

  it "links to new sample form" do
    @sign_in_user.call(@user)
    click_link "Upload a sample"
    page.should have_content "Upload a new sample"
  end
end
