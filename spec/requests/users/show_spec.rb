require 'spec_helper'

describe "showing a user" do
  before :each do
    @user = User.make! :username => "Jimjamz", :bio => "One upon a time!", :email => "test@example.com"
    @sign_in_user = lambda { |user|
      visit sign_in_path
      fill_in "Email", :with => user.email
      fill_in "Password", :with => user.password
      click_button "Sign in"
    }
  end

  it "routes from /:username" do
    @sign_in_user.call(@user)
    visit user_path(@user)
    page.should have_content "One upon a time!"
  end

  it "links back to homepage" do
    other = User.make! :username => "MichaelJordan"
    @sign_in_user.call(@user)
    visit user_path(@user)
    click_link "Home"
    page.should have_content "Home"
  end
end
