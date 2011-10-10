require 'spec_helper'

describe "home page" do
  before :each do
    @user = User.make! :username => "testuser", :email => "test@example.com"
  end

  it "shows user if user signed in" do
    visit "/sign_in"
    fill_in "Email", :with => "test@example.com"
    fill_in "Password", :with => "password"
    click_button "Sign in"
    visit "/"
    page.should have_content "testuser"
  end

  it "redirects to sign_in page if no one signed in" do
    visit "/"
    page.should have_content "Sign in"
  end
end
