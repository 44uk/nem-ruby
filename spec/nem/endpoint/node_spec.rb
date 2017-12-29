require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Node do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#max_chain_height' do
      subject { endpoint.max_chain_height }
      it { is_expected.to be_a Numeric }
    end

    describe '#info' do
      subject { endpoint.info }
      it { is_expected.to be_a Nem::Model::Node }
    end

    describe '#extended_info' do
      subject { endpoint.extended_info }
      it { is_expected.to be_a Nem::Model::NisNodeInfo }
    end

    describe '#experiences' do
      subject { endpoint.experiences }
      it { is_expected.to be_a Array }
    end

    describe '#peerlist_active' do
      subject { endpoint.peerlist_active }
      it { is_expected.to be_a Array }
    end

    describe '#peerlist_reachable' do
      subject { endpoint.peerlist_reachable }
      it { is_expected.to be_a Array }
    end

    describe '#peerlist_all' do
      subject { endpoint.peerlist_all }
      it { is_expected.to be_a Struct }
    end
  end

  context 'webmock' do
    it_behaves_like 'call endpoint methods'
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
