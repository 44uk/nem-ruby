require 'spec_helper'

describe Nem::Fee::MosaicSupplyChangeTransfer do
  let(:mosaic_id) { Nem::Model::MosaicId.new(namespace_id: 'sushi', name: 'magro') }
  let(:mode) { :increase }
  let(:delta) { 1_000 }
  let(:network) { :testnet }
  let(:tx) do
    Nem::Transaction::MosaicSupplyChange.new(
      mosaic_id,
      mode,
      delta,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'increase' do
    it { is_expected.to eq 150_000 }
  end

  context 'decrease' do
    let(:mode) { :descrease }
    it { is_expected.to eq 150_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'activate' do
      it { is_expected.to eq 150_000 }
    end

    context 'decrease' do
      let(:mode) { :descrease }
      it { is_expected.to eq 150_000 }
    end
  end
end
