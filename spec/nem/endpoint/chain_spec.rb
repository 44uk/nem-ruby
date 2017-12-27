require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Chain do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#last_block' do
    it { expect(subject.last_block).to be_a Nem::Model::Block }
  end

  describe '#height' do
    it { expect(subject.height).to be_a Numeric }
  end

  describe '#score' do
    it { expect(subject.score).to be_a String }
  end
end
