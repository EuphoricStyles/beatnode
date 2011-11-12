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

  describe 'crate link' do
    it 'is on page' do
      page.should have_button 'Crate it'
    end

    it 'changes once clicked' do
      click_button 'Crate it'
      page.should have_button 'Remove from crate'
    end

    it 'adds a download link after click' do
      page.should_not have_link 'Download'
      click_button 'Crate it'
      page.should have_link 'Download'
    end

    it 'removes download link' do
      click_button 'Crate it'
      page.should have_link 'Download'
      click_button 'Remove from crate'
      page.should_not have_link 'Download'
    end
  end
end
