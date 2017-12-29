require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Namespace do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#find' do
      subject { endpoint.find('nemether') }
      it { is_expected.to be_a Nem::Model::Namespace }
      it { expect(subject.owner).to eq 'NC56RYVRUPG3WRNGMVNRKODJZJNZKZYS76UAPO7K' }
      it { expect(subject.fqn).to eq 'nemether' }
      it { expect(subject.height).to eq 1327882 }
    end

    describe '#root' do
      subject { endpoint.root(26754, page_size: 35) }
      it { is_expected.to be_a Array }
    end

    describe '#mosaic_definition' do
      subject { endpoint.mosaic_definition('nemether') }
      it { is_expected.to be_a Array }
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
