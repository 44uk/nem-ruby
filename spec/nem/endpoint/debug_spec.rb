require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Debug do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#time_syncronization' do
      subject { endpoint.time_syncronization }
      it { is_expected.to be_a Array }
    end

    describe '#timers' do
      subject { endpoint.timers }
      it { is_expected.to be_a Array }
    end

    describe '#connections_incoming' do
      subject { endpoint.connections_incoming }
      it { is_expected.to be_a Struct }
    end

    describe '#connections_outgoing' do
      subject { endpoint.connections_outgoing }
      it { is_expected.to be_a Struct }
    end

    describe '#connections' do
      subject { endpoint.connections(:in) }
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
