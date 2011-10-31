require 'spec_helper'

describe 'the feed' do
  before :each do
    @user = User.make!
    @watched = User.make! :username => 'watcheduser'
    @user.watch!(@watched)
    visit sign_in_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_button 'Sign in'
  end

  describe 'samples/_feed.html.erb' do
    before :each do
      @sample = Sample.make! :user => @watched
      visit root_path
    end

    it 'shows sample info' do
      page.should have_content "watcheduser uploaded #{@sample.name}"
    end

    it 'shows timestamp' do
      page.should have_content pretty_timestamp(@sample.created_at)
    end
  end

  describe 'beats/_feed.html.erb' do
    before :each do
      @beat = Beat.make! :user => @watched
      visit root_path
    end

    it 'shows beat info' do
      page.should have_content "watcheduser uploaded #{@beat.name}"
    end

    it 'shows timestamp' do
      page.should have_content pretty_timestamp(@beat.created_at)
    end
  end

  describe 'sample_borrows/_feed.html.erb' do
    before :each do
      @sample = Sample.make!
      @user.borrow!(@sample)
      visit root_path
    end

    it 'shows sample_borrow info' do
      page.should have_content "You added #{@sample.name} to your crate"
    end

    it 'shows timestamp' do
      sb = @user.borrowed_samples.first
      page.should have_content pretty_timestamp(sb.created_at)
    end
  end
end
