require 'spec_helper'

describe 'beat uploads' do
  before :each do
    @user = User.make!
    @beat = Beat.make! :user => @user, :name => 'first beat', :description => 'the first one'
    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
  end

  describe '#create' do
    before(:each) do
      @upload_it = lambda { |name, desc|
        visit home_path
        click_link 'Upload a beat'
        fill_in 'Name', :with => name
        fill_in 'Description', :with => desc
        attach_file "Audio", "#{Rails.root}/data/audio/rickyrice.mp3"
        click_button 'Upload'
      }
    end

    it 'has an upload form' do
      visit new_beat_path
      page.should have_content 'Upload a beat'
    end

    it 'creates a beat' do
      expect { @upload_it.call('name', 'desc') }.to change(Beat, :count).by(1)
      page.should have_content 'Beat uploaded'
    end

    it 'redirects to show page' do
      @upload_it.call('test beat', 'test desc')
      current_path.should == beat_path(Beat.last)
    end
  end

  describe '#show' do
    before :each do
      visit beat_path(@beat)
    end

    it 'shows beat' do
      page.should have_content 'first beat'
      page.should have_content 'the first one'
    end
  end
end
