require 'spec_helper'

describe 'showing beats' do
  before :each do 
    @user =User.make!
    @beat = Beat.make! :name => 'test beat', :description => 'testdesc!'

    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
  end

  it 'is successful' do
    visit beat_path(@beat)
  end

  it 'has the beat name' do
    visit beat_path(@beat)
    page.should have_content('test beat')
  end

  it 'has the beat description' do
    visit beat_path(@beat)
    page.should have_content('testdesc!')
  end

end
