require 'spec_helper'

describe Nem::Fee::MultisigAggregateModification do
  let(:cosignatories) do
    [ Nem::Transaction::MultisigCosignatoryModification.new(:add, '') ]
  end
  let(:relative_change) { 1 }
  let(:network) { :testnet }
  let(:tx) do
    Nem::Transaction::MultisigAggregateModification.new(
      cosignatories,
      relative_change,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'increase' do
    it { is_expected.to eq 500_000 }
  end

  context 'decrease' do
    let(:mode) { :descrease }
    it { is_expected.to eq 500_000 }
  end

  context '0 cosignatory' do
    let(:min_cosigs) { 0 }
    it { is_expected.to eq 500_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'activate' do
      it { is_expected.to eq 500_000 }
    end

    context 'decrease' do
      let(:mode) { :descrease }
      it { is_expected.to eq 500_000 }
    end

    context '0 cosignatory' do
      let(:min_cosigs) { 0 }
      it { is_expected.to eq 500_000 }
    end
  end
end
