require 'spec_helper'

describe "user registration" do
  it "signs up users" do
    visit new_user_registration_path
    fill_in "Username", :with => 'rickyrickyrice'
    fill_in "Email", :with => 'alex@beatnode.com'
    fill_in "Password", :with => 'password'
    fill_in "Confirm password", :with => 'password'
    click_button "Sign up"
    page.should have_content "Successfully signed up"
  end

  it "fails on duplicate records" do
    User.make! :username => "rickyrickyrice2", :email => "ricky@rick.com"
    visit new_user_registration_path
    fill_in "Username", :with => 'riCkyrickYrice2'
    fill_in "Email", :with => 'Ricky@rick.com'
    fill_in "Password", :with => 'password'
    fill_in "Confirm password", :with => 'password'
    click_button "Sign up"
    page.should have_content "Username has already been taken"
    page.should have_content "Email has already been taken"
  end
end
