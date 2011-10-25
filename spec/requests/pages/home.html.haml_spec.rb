require 'spec_helper'

describe "pages/home.html.haml" do
  before :each do
    @user = User.make! :username => "testuser", :email => "test@example.com"
    visit sign_in_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
  end

  it "has link to homepage" do
    page.should have_link "Home"
    click_link "Home"
    current_path.should == root_path
  end

  it "links to new sample form" do
    click_link "Upload a sample"
    page.should have_content "Upload a sample"
  end

  it "says if user doesn't have a bio" do
    nobio = User.make! :bio => nil

    click_link 'Sign out'
    visit sign_in_path
    fill_in "Email", :with => nobio.email
    fill_in "Password", :with => nobio.password
    click_button "Sign in"
    page.should have_content "You haven't added a bio yet!"
  end
end