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
  end
end
