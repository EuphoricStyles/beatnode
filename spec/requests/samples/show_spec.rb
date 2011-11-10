require 'spec_helper'

describe 'samples/show.html.haml' do
  before :each do
    get 'samples#show'
  end

  it 'has a download link' do
    page.should have_link 'Download'
  end
end
