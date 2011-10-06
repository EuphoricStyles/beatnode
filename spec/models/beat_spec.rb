require 'spec_helper'

describe Beat do
  before :each do
    @creator = User.make!
    @beat = Beat.make! :creator => @creator
  end

  after :each do
    @beat.remove_audio!
  end

  it "has a title, description, and audio attachment" do
    @beat.title.should =~ /some beat/i
    @beat.description.should =~ /beat beat beat/i
    @beat.audio.should_not be_nil
  end

  it "has a creator" do
    @beat.creator.should == @creator
  end

  it "rejects large file sizes" do
    expect { Beat.make!(:audio => open("#{Rails.root}/data/audio/big_audio.mp3")) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "rejects invalid extensions" do
    expect { Beat.make!(:audio => open("#{Rails.root}/data/audio/big_audio.m4a")) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
