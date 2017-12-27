require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Mosaic do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#supply' do
    it { expect(subject.supply('nembar:vip')).to be_a Nem::Model::MosaicSupply }
  end
end
