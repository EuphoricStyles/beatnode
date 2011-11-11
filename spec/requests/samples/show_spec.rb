require 'spec_helper'

describe 'samples/show.html.haml' do
  before :each do
    @sample = Sample.make!
    @user = User.make!
    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
    visit sample_path(@sample)
  end

  it 'has a download link' do
    page.should have_link 'Download'
  end
end
