require 'spec_helper'

describe PagesController do
  render_views

  before :each do
    @user = User.make! :username => 'testuser'
    sign_in @user
    get :home
  end

  it "is successful" do
    response.should be_successful
  end

  it 'has the username' do
    response.body.should have_content('Home for testuser')
  end

  it "redirects to sign_in page if no one signed in" do
    sign_out @user
    get :home
    response.should redirect_to(:action => :welcome)
  end
end
