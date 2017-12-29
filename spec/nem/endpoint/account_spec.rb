require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Account do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    let(:nem_address) { 'NANEMOABLAGR72AZ2RV3V4ZHDCXW25XQ73O7OBT5' }
    let(:nem_public_key) { '8d07f90fb4bbe7715fa327c926770166a11be2e494a970605f2e12557f66c9b9' }
    let(:address) { 'NCYP7E7S67LB4G4Y4RJWE7REFBZI4EXJ73MRKIWW' }
    let(:public_key) { '719862cd7d0f4e875a6a0274c9a1738f38f40ad9944179006a54c34724c1274d' }
    let(:msig_address) { 'NDEVPOSK4OMR4PRTLYFHX4W5QTOND7TZDT2DTU4Q' }
    let(:msig_public_key) { '56a7ae8caca7356fffe98e1dfdf3f4218bb837b5ec6aae927a964e2ff1861e20' }

    # describe '#generate' do
    #   subject { endpoint.generate }
    #   it { is_expected.to be_a Nem::Model::Keypair }
    #   it { expect(subject.public_key).to eq public_key }
    # end

    describe '#find' do
      subject { endpoint.find(address) }
      it { is_expected.to be_a Nem::Model::Account }
      it { expect(subject.public_key).to eq public_key }
    end

    describe '#find_by_public_key' do
      subject { endpoint.find_by_public_key(public_key) }
      it { is_expected.to be_a Nem::Model::Account }
      it { expect(subject.address).to eq address }
    end

    describe '#historical' do
      subject { endpoint.historical(msig_address,
        start_height: 1,
        end_height: 100_000,
        increment: 1000
      ) }
      it { is_expected.to be_a Array }
    end

    describe '#harvests' do
      subject { endpoint.harvests(nem_address) }
      it { is_expected.to be_a Array }
    end

    describe '#importances' do
      subject { endpoint.importances }
      it { is_expected.to be_a Array }
    end

    describe '#status' do
      subject { endpoint.status(msig_address) }
      it { is_expected.to be_a Nem::Model::Account }
    end

    describe '#transfers_incoming' do
      subject { endpoint.transfers_incoming(nem_address) }
      it { is_expected.to be_a Array }
    end

    describe '#transfers_outgoing' do
      subject { endpoint.transfers_outgoing(nem_address) }
      it { is_expected.to be_a Array }
    end

    describe '#transfer_unconfirmed' do
      subject { endpoint.transfers_unconfirmed(nem_address) }
      it { is_expected.to be_a Array }
    end

    describe '#transfer_all' do
      subject { endpoint.transfers_all(nem_address) }
      it { is_expected.to be_a Array }
    end

    describe '#namespace' do
      subject { endpoint.namespace('NC56RYVRUPG3WRNGMVNRKODJZJNZKZYS76UAPO7K') }
      it { is_expected.to be_a Array }
    end

    describe '#mosaic_definition' do
      subject { endpoint.mosaic_definition('NC56RYVRUPG3WRNGMVNRKODJZJNZKZYS76UAPO7K', parent: 'nemether') }
      it { is_expected.to be_a Array }
    end

    describe '#mosaic_owned' do
      subject { endpoint.mosaic_owned('NC56RYVRUPG3WRNGMVNRKODJZJNZKZYS76UAPO7K') }
      it { is_expected.to be_a Array }
    end
  end

  context 'webmock' do
    it_behaves_like 'call endpoint methods' do
      let(:node) { Nem::Node.new }
    end
  end

  if ENV['remote'] == 'enable'
    context 'remote node' do
      it_behaves_like 'call endpoint methods' do
        let(:webmock) { false }
        let(:node) { Nem::Node.new(host: '176.9.68.110') }
      end
    end
  end
end
