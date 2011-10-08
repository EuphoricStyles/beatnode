require 'spec_helper'

describe "user registration" do
  it "signs up users" do
    visit "/sign_up"
    fill_in "Username", :with => 'rickyrickyrice'
    fill_in "Password", :with => 'password'
    fill_in "Confirm password", :with => 'password'
    click_button "Sign up"
    page.should have_content "Successfully signed up"
  end
end
