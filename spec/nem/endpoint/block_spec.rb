require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Block do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#at_public' do
      subject { endpoint.at_public(100_000) }
      it { is_expected.to be_a Nem::Model::Block }
      it { expect(subject.signature).to eq 'bf7fd862c0793dfb9ef9d5cf965196b8573ee5de776fe5fd48669958bae106d33b6774ea27d22636e6dbea34294eb576a9006d3855689e0a4f47d7601a3abd00' }
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
