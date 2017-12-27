require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Debug do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#time_syncronization' do
    it { expect(subject.time_syncronization).to be_a Array }
  end

  describe '#timers' do
    it { expect(subject.timers).to be_a Array }
  end

  describe '#connections_incoming' do
    it { expect(subject.connections_incoming).to be_a Struct }
  end

  describe '#connections_outgoing' do
    it { expect(subject.connections_outgoing).to be_a Struct }
  end

  describe '#connections' do
    it { expect(subject.connections(:in)).to be_a Struct }
  end
end
