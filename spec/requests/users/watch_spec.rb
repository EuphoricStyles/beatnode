require 'spec_helper'

describe 'watching' do
  before :each do
    @user = User.make!
    @other = User.make! :username => 'other'
    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
    visit user_path @other
  end

  it 'has a "Watch" link' do
    page.should have_link 'Watch'
  end

  it 'adds a user relationship' do
    expect { click_link 'Watch' }.to change(UserRelationship, :count).by(1)
  end

  it 'has "unwatch" link' do
    page.should_not have_link 'Unwatch'
    click_link 'Watch'
    page.should have_link 'Unwatch'
    page.should_not have_link 'Watch'
  end
end
