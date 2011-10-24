require 'spec_helper'

describe 'beats index' do
  before :each do
    @user = User.make!
    5.times do |i|
      Beat.make! :user => @user, :name => "beat #{i}"
    end

    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
  end

  it 'has a link on the home page' do
    page.should have_link 'Beats'
  end
end
