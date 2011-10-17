require 'spec_helper'

describe ApplicationHelper do
  before :each do
    Time.stub!(:now).and_return(Time.local(2011, 7, 8, 10, 0, 0))
  end

  describe '#pretty_timestamp' do
    it 'handles same day' do
      pretty_timestamp(Time.now - 2.hours).should == 'at 08:00 AM'
    end

    it 'handles yesterday' do
      pretty_timestamp(Time.now - 1.day).should == 'yesterday at 10:00 AM'
    end

    it 'handles under a week ago' do
      pretty_timestamp(Time.now - 6.days).should == '6 days ago'
    end

    it 'handles long time ago, but same year' do
      pretty_timestamp(Time.now - 3.months).should == 'on April 8'
    end

    it 'handles different year' do
      pretty_timestamp(Time.now - 7.months).should == 'on December 8, 2010'
    end
  end
end
