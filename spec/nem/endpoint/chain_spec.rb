require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Chain do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#last_block' do
      subject { endpoint.last_block }
      it { is_expected.to be_a Nem::Model::Block }
    end

    describe '#height' do
      subject { endpoint.height }
      it { is_expected.to be_a Numeric }
      it { is_expected.to be > 1 }
    end

    describe '#score' do
      subject { endpoint.score }
      it { is_expected.to be_a String }
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
