require 'spec_helper'

describe AudioComponent do
  it "rejects large file sizes" do
    expect { AudioComponent.make!(:audio => open("#{Rails.root}/data/audio/big_audio.mp3")) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "rejects invalid extensions" do
    expect { AudioComponent.make!(:audio => open("#{Rails.root}/data/audio/big_audio.m4a")) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
