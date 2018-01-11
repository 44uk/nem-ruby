require 'spec_helper'

describe Nem::Request::Announce do
  before { Timecop.freeze Time.utc(2015, 3, 29, 0, 6, 25, 0) }
  after  { Timecop.return }

  let(:recipient) { 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF' }
  let(:mosaics) { [Nem::Mosaic::Xem.new(1), Nem::Mosaic::EcobitEco.new(200)] }
  let(:tx) {
    Nem::Transaction::Transfer.new(recipient, 1, 'Good luck!',
      timestamp: Time.now,
      deadline: Time.now + 3600,
      mosaics: mosaics
    )
  }
  let(:priv) { '4ce5c8f9fce571db0d9ac1adf00b8d3ba0f078ed40835fd3d730a2f24b834214' }
  let(:kp) { Nem::Keypair.new(priv) }
  let(:req) { Nem::Request::Announce.new(tx, kp) }

  describe '#to_entity' do
    subject { req.to_entity(:prepare) }
    it { is_expected.to be_a Hash }
    it { expect(subject[:transaction]).to eq(
      type: 257,
      recipient: 'TA4TX6U5HG2MROAESH2JE5524T4ZOY2EQKQ6ELHF',
      amount: 1_000_000,
      fee: 150_000,
      timeStamp: 0,
      deadline: 3_600,
      message: { payload: '476f6f64206c75636b21', type: 1 },
      mosaics: [
        { mosaicId: { namespaceId: 'ecobit', name: 'eco' }, quantity: 200 },
        { mosaicId: { namespaceId: 'nem', name: 'xem' }, quantity: 1000000 }
      ],
      signer: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
      version: 2550136834
    ) }
  end

  context 'serialized' do
    describe '#to_entity' do
      subject { req.to_entity }
      it { is_expected.to be_a Hash }
      it { expect(subject[:data]).to match(/\h+/) }
      it { expect(subject[:signature]).to match(/\h+/) }
    end
  end
end
