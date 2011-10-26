require 'spec_helper'

describe SampleUse do
  before :each do
    @beat = Beat.make!
    @sample = Sample.make!
    @su = @beat.sample_uses.build(:sample_id => @sample.id)
  end

  it 'is valid' do
    @su.save!
  end

  describe 'after save' do
    before :each do
      @su.save!
    end

    it 'validates uniqueness' do
      invalid = @beat.sample_uses.build(:sample_id => @sample.id)
      expect { invalid.save! }.to raise_exception(ActiveRecord::RecordNotUnique)
    end
  end
end
