require 'spec_helper'

describe Nem::Unit::Time do
  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  let(:value) { Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  let(:time) { described_class.new(value) }

  describe '#to_i' do
    subject { time.to_i }
    it { is_expected.to eq 0 }
  end

  describe '#to_time' do
    subject { time.to_time.to_i }
    it { is_expected.to eq value.to_i }
  end

  context 'parse from time string' do
    let(:value) { '2015-03-29T01:06:25Z' }
    let(:time) { described_class.parse(value) }

    describe '#to_i' do
      subject { time.to_i }
      it { is_expected.to eq 3600 }
    end

    describe '#to_time' do
      subject { time.to_time.to_i }
      it { is_expected.to eq Time.parse(value).to_i }
    end
  end

  context '.new_from_nemtime' do
    let(:value) { 7200 }
    let(:time) { described_class.new_from_nemtime(value) }

    describe '#to_i' do
      subject { time.to_i }
      it { is_expected.to eq 7200 }
    end
  end
end
