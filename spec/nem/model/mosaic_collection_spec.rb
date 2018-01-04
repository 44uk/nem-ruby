require 'spec_helper'

describe Nem::Model::MosaicCollection do
  let(:mosaics) {
    [
      Nem::Mosaic::Xem.new(1),
      Nem::Mosaic::DimCoin.new(1),
      Nem::Mosaic::DimToken.new(1),
      Nem::Mosaic::EcobitEco.new(1)
    ]
  }
  let(:collection) { described_class.new(mosaics) }

  describe '#size' do
    it { expect(collection.size).to eq 4 }
  end

  describe '#map' do
    it { expect(collection.map(&:fqn)).to be_a Array }
  end

  describe '#find_by_fqn' do
    subject { collection.find_by_fqn('ecobit:eco')  }
    it { expect(subject.fqn).to eq 'ecobit:eco' }
  end

  describe '#[]' do
    subject { collection['dim:coin']  }
    it { expect(subject.fqn).to eq 'dim:coin' }
  end

  describe '#find_by_namespace_id' do
    subject { collection.find_by_namespace_id('dim')  }
    it { is_expected.to be_a Nem::Model::MosaicCollection }
    it { expect(subject.size).to eq 2 }
    it { expect(subject.find_by_fqn('dim:coin').fqn).to eq 'dim:coin' }
  end
end
