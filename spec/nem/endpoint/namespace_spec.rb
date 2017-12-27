require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Namespace do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#find' do
    it { expect(subject.find('makoto.metal.coins')).to be_a Nem::Model::Namespace }
  end

  describe '#root' do
    it { expect(subject.root(26754, page_size: 35)).to be_a Array }
  end

  describe '#mosaic_definition' do
    it { expect(subject.mosaic_definition('makoto.metal.coins')).to be_a Array }
  end
end
