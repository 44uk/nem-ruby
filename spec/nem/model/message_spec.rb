require 'spec_helper'

describe Nem::Model::Message do
  let(:msg) { 'Good luck!' }
  let(:type) { :plain }
  let(:private_key) { nil }
  let(:public_key) { nil }

  subject do
    described_class.new(
      msg,
      type: type,
      private_key: private_key,
      public_key: public_key
    )
  end

  context 'Plain message' do
    it { expect(subject.hex?).to be false }
    it { expect(subject.encrypted?).to be false }
    it { expect(subject.payload).to eq '476f6f64206c75636b21' }
  end

  context 'Hexdecimal message' do
    let(:msg) { 'febaadf00ddeadbeef' }

    it { expect(subject.hex?).to be true }
    it { expect(subject.encrypted?).to be false }
    it { expect(subject.payload).to eq msg }
  end

  context 'Encrypted message' do
    let(:type) { :encrypt }
    let(:private_key) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
    let(:public_key) { '9e7ab2924cd1a3482df784db190614cfc8a33671f5d80a5b15a9c9e8b4d13933' }

    before { subject.encrypt! }

    it { expect(subject.hex?).to be false }
    it { expect(subject.encrypted?).to be true }
    it { expect(subject.payload).to match(/\A\h+\z/) }
  end
end
