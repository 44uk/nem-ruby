require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Transaction do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#find' do
      subject { endpoint.find('7b0b441343d8a67e43810600fb4885b93a9dc90316b406dc5d90206edf7f2b1d') }
      it { is_expected.to be_a Nem::Model::Transaction }
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
