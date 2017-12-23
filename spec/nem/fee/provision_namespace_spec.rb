require 'spec_helper'

describe Nem::Fee::ProvisionNamespace do
  let(:newpart) { 'sushi' }
  let(:parent)  { nil }
  let(:network) { :testnet }
  let(:tx) do
    Nem::Transaction::ProvisionNamespace.new(
      newpart,
      parent,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  context 'root' do
    it { is_expected.to eq 150_000 }
  end

  context 'sub' do
    let(:parent)  { 'sushi' }
    it { is_expected.to eq 150_000 }
  end

  context 'on mainnet' do
    let(:network) { :maitnet }

    context 'root' do
      it { is_expected.to eq 150_000 }
    end

    context 'sub' do
      let(:parent)  { 'sushi' }
      it { is_expected.to eq 150_000 }
    end
  end

end
