require 'spec_helper'

describe "sample borrowing" do
  before :each do
    @sample = Sample.make! :name => "to be borrowed"
    @user = User.make! :email => "test@test.com"

    visit new_user_session_path
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "password"
    click_button "Sign in"
  end

  it "borrows a sample" do
    visit sample_path(@sample.id)
    click_button "Grab"
    visit "/"
    page.should have_content "to be borrowed"
  end
end
