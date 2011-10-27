require 'spec_helper'

describe SampleBorrow do
  before :each do
    @user = User.make!
    @watched = User.make!
    @user.watch!(@watched)
    @sample = Sample.make!

    @sb = @watched.sample_borrows.build(:sample_id => @sample.id)
  end

  it 'is valid' do
    @sb.save!
  end
end
