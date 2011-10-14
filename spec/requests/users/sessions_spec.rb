require 'spec_helper'

describe "user sessions" do
  before :each do
    @user = User.make! :username => "jeff", :email => "jeff@gmail.com"
    @sign_in_user = lambda { |user|
      visit sign_in_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
    }
  end

  it "signs in existing users" do
    @sign_in_user.call(@user)
    page.should have_content 'Signed in successfully'
  end

  it "fails on wrong email" do
    visit sign_in_path
    fill_in "Email", :with => "jeff@gmail.co"
    fill_in "Password", :with => "password"
    click_button "Sign in"
    page.should have_content "Invalid email"
  end

  it "signs out current user" do
    @sign_in_user.call(@user)

    click_link "Sign out"
    page.should have_content 'Signed out successfully'
  end
end
