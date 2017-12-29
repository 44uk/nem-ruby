require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Mosaic do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }
    let(:fqn) { 'nemether:nemether' }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#supply' do
      subject { endpoint.supply(fqn) }
      it { is_expected.to be_a Nem::Model::MosaicSupply }
      it { expect(subject.supply).to eq 95100000 }
      it { expect(subject.supply).to be >= 1 }
      it { expect(subject.id).to be_a Nem::Model::MosaicId }
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
