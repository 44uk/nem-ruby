require 'spec_helper'

describe Nem::Transaction::Transfer do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount) { 1 }
  let(:message) { nil }
  let(:mosaics) { [] }
  let(:network) { :testnet }

  subject {
    described_class.new(
      recipient,
      amount,
      message,
      mosaics: mosaics,
      network: network
    )
  }

  describe 'version' do
    it { expect(subject.version).to eq 0x98000001 }
  end

  describe 'transfer?' do
    it { expect(subject.transfer?).to be true }
    it { expect(subject.multisig?).to be false }
    it { expect(subject.has_message?).to be false }
    it { expect(subject.has_mosaics?).to be false }
  end

  context 'has message' do
    let(:message) { 'Good luck!' }

    it { expect(subject.has_message?).to be true }
  end

  context 'has mosaics' do
    let(:mosaics) { [
      Nem::Mosaic::Xem.new(1),
      Nem::Mosaic::EcobitEco.new(100)
    ] }

    it { expect(subject.has_mosaics?).to be true }
    it { expect(subject.mosaics.size).to eq 2 }
  end

  describe '#to_hash' do
    it { expect(subject.to_hash).to match a_hash_including(
      amount: 1_000_000,
      recipient: 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF',
      message: { payload: '', type: 1 }
    ) }

    context 'has decimal amount' do
      let(:amount) { 0.001 }

      it { expect(subject.to_hash).to match a_hash_including(
        amount: 1_000
      ) }

      it { expect(subject.to_hash[:amount]).to be_a(Integer) }
    end

    context 'has decimal quantity mosaics' do
      let(:mosaics) { [
        Nem::Mosaic::DimToken.new(0.001)
      ] }

      it { expect(subject.to_hash).to match a_hash_including(
        mosaics: [{ mosaicId: { namespaceId: 'dim', name: 'token' }, quantity: 1000 }]
      ) }

      it { expect(subject.to_hash[:mosaics].first[:quantity]).to be_a(Integer) }
    end
  end
end
