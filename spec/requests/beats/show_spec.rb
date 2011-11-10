require 'spec_helper'

describe 'beats/show.html.haml' do
  before :each do
    get 'beats#show'
  end

  it 'has a download link' do
    page.should have_link 'Download'
  end
end
