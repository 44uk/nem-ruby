require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Timesync do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#network_time' do
      subject { endpoint.network_time }
      it { is_expected.to be_a Nem::Model::NetworkTime }
      it { expect(subject.send_timestamp).to be > 1 }
      it { expect(subject.receive_timestamp).to be > 1 }
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
