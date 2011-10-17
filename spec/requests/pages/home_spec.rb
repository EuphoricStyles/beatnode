require 'spec_helper'

describe "home page" do
  before :each do
    @user = User.make! :username => "testuser", :email => "test@example.com"
    visit sign_in_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Sign in"
  end

  it "shows user if user signed in" do
    page.should have_content "Home for testuser"
  end

  it "redirects to sign_in page if no one signed in" do
    click_link 'Sign out'
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
    nobio = User.make! :bio => nil

    click_link 'Sign out'
    visit sign_in_path
    fill_in "Email", :with => nobio.email
    fill_in "Password", :with => nobio.password
    click_button "Sign in"
    page.should have_content "You haven't added a bio yet!"
  end

  it "lists borrowed samples" do
    s = Sample.make! :user => User.make!(:username => 'barry')
    visit sample_path(s)
    click_button "Grab"
    current_path.should == root_path
    page.should have_content s.name
    page.should have_content "Borrowed from barry at #{s.created_at}"
  end

  it "lists owned samples" do
    s = Sample.make! :user => @user
    visit root_path
    page.should have_content s.name
    page.should have_content "Uploaded at #{s.created_at}"
  end
end
