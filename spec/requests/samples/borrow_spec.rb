require 'spec_helper'

describe "sample borrowing" do
  before :each do
    @sample = Sample.make! :name => "to be borrowed"
    @user = User.make! :email => "test@test.com"

    visit sign_in_path
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "password"
    click_button "Sign in"
  end

  it "borrows a sample" do
    visit sample_path(@sample)
    click_button "Grab"
    visit root_path
    click_link "My samples"
    page.should have_content "to be borrowed"
  end
end
