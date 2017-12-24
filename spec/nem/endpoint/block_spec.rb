require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Block do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#at_public' do
    subject { endpoint.at_public(2649) }
    it { is_expected.to be_a Nem::Model::Block }
    it { expect(subject.signature).to eq '005f91b8908fc173a428ff8e8c4a0ee0d69e4004aed0d08f27690b6b6672ef74ccc6b89695bed5f29b0f4a812cb84bfa459f52a4e14a11e574793969f0e1a30f' }
  end
end
