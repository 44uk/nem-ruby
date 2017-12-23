require 'spec_helper'

describe Nem::Transaction::Multisig do
  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:amount) { 1 }
  let(:message) { nil }
  let(:mosaics) { [] }
  let(:network) { :testnet }
  let(:trans) {
    Nem::Transaction::Transfer.new(
      recipient,
      amount,
      message,
      mosaics: mosaics,
      network: network
    )
  }
  let(:signer_public_key) { '00f077782658ae91b77f238ba5fcd7ef110564b5c189072e4d4590d9b17f9d76f3' }

  subject {
    described_class.new(
      trans,
      signer_public_key,
      network: network
    )
  }

  describe 'multisig?' do
    it { expect(subject.multisig?).to be true }
  end
end
