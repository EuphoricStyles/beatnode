require 'spec_helper'

describe Sample do
  before :each do
    @owner = User.make! 
    @borrower = User.make!
    @sample = Sample.make! :user => @owner, :description => "posted by @owner"
  end

  after :each do
    @sample.remove_audio!
  end

  it "has a name, description, and audio attachment" do
    @sample.name.should == 'rickyrice.mp3'
    @sample.description.should == "posted by @owner"
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

  it "validates description length" do
    expect { Sample.make!(:description => 'a'*601) }.to raise_error(ActiveRecord::RecordInvalid)
    expect { Sample.make!(:description => 'a'*600) }.not_to raise_error
  end

  it "has tags" do
    @sample.tag_list = "piano, drums, bass"
    @sample.tag_list.should == %w{ piano drums bass}
  end
end
