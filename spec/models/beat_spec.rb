require 'spec_helper'

describe Beat do
  before :each do
    @user = User.make!
    @beat = Beat.make! :user => @user, :name => 'some beat', :description => 'beat beat beat'
  end

  it "has a creator" do
    @beat.user.should == @user
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

  describe '.which_sample' do
    before :each do
      @sample = Sample.make!
      @use = @beat.sample_uses.create!(:sample_id => @sample.id)
    end

    it 'returns all beats that use a certain sample' do
      Beat.which_sample(@sample).should include(@beat)
    end
  end
end
