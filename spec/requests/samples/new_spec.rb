require 'spec_helper'

describe 'sample creation' do
  before :each do
    @user = User.make! :username => "testdummy", :email => "test@test.com"
    @sample = @user.samples.create(
      :name => "sample1",
      :description => "first test sample",
      :audio => open("#{Rails.root}/data/audio/rickyrice.mp3")
    )

    visit new_user_session_path
    fill_in "Email", :with => "test@test.com"
    fill_in "Password", :with => "password"
    click_button "Sign in"
  end

  it "has a new sample form" do
    visit "/samples/new"
    page.should have_content "Upload a new sample"
  end

  it "creates a new sample" do
    visit new_sample_path
    fill_in "Name", :with => "Test sample"
    fill_in "Description", :with => "My first sample"
    attach_file "Audio", "#{Rails.root}/data/audio/rickyrice.mp3"
    click_button "Upload"
    page.should have_content "Sample uploaded"
  end

  it "validates the form" do
    visit new_sample_path
    click_button "Upload"
    page.should have_content "Audio can't be blank"
  end
end
