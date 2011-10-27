require 'spec_helper'

describe Beat do
  before :each do
    @user = User.make!
    @beat = Beat.make! :user => @user, :name => 'some beat', :description => 'beat beat beat'
  end

  after :each do
    @beat.remove_audio!
  end

  it "has a name, description, and audio attachment" do
    @beat.name.should == 'some beat'
    @beat.description.should == 'beat beat beat'
    @beat.audio.should_not be_nil
  end

  it "has a creator" do
    @beat.user.should == @user
  end

  it "rejects large file sizes" do
    expect { Beat.make!(:audio => open("#{Rails.root}/data/audio/big_audio.mp3")) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "rejects invalid extensions" do
    expect { Beat.make!(:audio => open("#{Rails.root}/data/audio/big_audio.m4a")) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "validates description length" do
    expect { Beat.make!(:description => 'a'*201) }.to raise_error(ActiveRecord::RecordInvalid)
    expect { Beat.make!(:description => 'a'*200) }.not_to raise_error
  end

  it "validates name length" do
    expect { Beat.make!(:name => 'a'*76) }.to raise_error(ActiveRecord::RecordInvalid)
    expect { Beat.make!(:name => 'a'*75) }.not_to raise_error
  end

  it "has tags" do
    @beat.tag_list = "piano, drums, bass"
    @beat.tag_list.should == %w{ piano drums bass}
  end

  describe '.from_watching' do
    before :each do
      @u = User.make!
      5.times { @u.watch!(User.make!) }
      @b1 = Beat.make! :user_id => @u.watching.first.id
      @b2 = Beat.make! :user_id => @u.watching.last.id
    end

    it 'is a class method' do
      Beat.should respond_to(:from_watching)
    end

    it 'returns all beats created by watched users' do
      Beat.from_watching(@u).should == [ @b2, @b1 ]
    end
  end
end
