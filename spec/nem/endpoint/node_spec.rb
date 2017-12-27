require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Node do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#max_chain_height' do
    it { expect(subject.max_chain_height).to be_a Numeric }
  end

  describe '#info' do
    it { expect(subject.info).to be_a Nem::Model::Node }
  end

  describe '#extended_info' do
    it { expect(subject.extended_info).to be_a Nem::Model::NisNodeInfo }
  end

  describe '#experiences' do
    it { expect(subject.experiences).to be_a Array }
  end

  describe '#peerlist_active' do
    it { expect(subject.peerlist_active).to be_a Array }
  end

  describe '#peerlist_reachable' do
    it { expect(subject.peerlist_reachable).to be_a Array }
  end

  describe '#peerlist_all' do
    it { expect(subject.peerlist_all).to be_a Struct }
  end
end
