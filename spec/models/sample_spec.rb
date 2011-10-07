require 'spec_helper'

describe Sample do
  before :each do
    @owner = User.make! 
    @borrower = User.make!
    @sample = Sample.make! :user => @owner
  end

  after :each do
    @sample.remove_audio!
  end

  it "has a title, description, and audio attachment" do
    @sample.title.should =~ /some sample/i
    @sample.description.should =~ /sample sample sample/i
    @sample.audio.should_not be_nil
  end

  it "has an owner" do
    @sample.user.should == @owner
  end

  it "rejects large file sizes" do
    expect { Beat.make!(:audio => open("#{Rails.root}/data/audio/big_audio.mp3")) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "rejects invalid extensions" do
    expect { Beat.make!(:audio => open("#{Rails.root}/data/audio/big_audio.m4a")) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
