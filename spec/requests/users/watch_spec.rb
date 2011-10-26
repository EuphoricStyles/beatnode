require 'spec_helper'

describe 'watching users' do
  before :each do
    @user = User.make!
    @other = User.make!
    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
    visit user_path @other
  end

  it 'has a "Watch" button' do
    page.should have_button 'Watch'
  end

  it 'has "unwatch" link' do
    click_button 'Watch'
    page.should have_button 'Unwatch'
  end
end
