require 'spec_helper'

describe "showing a user" do
  before :each do
    @user = User.make! :username => "Jimjamz", :bio => "One upon a time!", :email => "test@example.com"
  end

  it "routes from /:username" do
    visit user_path(@user.id)
    page.should have_content "One upon a time!"
  end
end
