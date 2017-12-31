require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Local::Chain do
  shared_examples 'call endpoint methods' do
    let(:webmock) { true }
    let(:node) { Nem::Node.new }
    let(:endpoint) { described_class.new(node) }

    before { WebMock.disable! unless webmock }
    after { WebMock.enable! }

    describe '#blocks_after' do
      subject { endpoint }
      it { expect(subject.blocks_after(2649)).to be_a Array }
    end
  end

  context 'webmock' do
    it_behaves_like 'call endpoint methods'
  end

  if ENV['remote'] == 'enable'
    context 'remote node' do
      it_behaves_like 'call endpoint methods' do
        let(:webmock) { false }
      end
    end
  end
end
