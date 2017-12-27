require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Local::Account do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#transfers_incoming' do
    it { expect(subject.transfers_incoming(
      '68e4f79f886927de698df4f857de2aada41ccca6617e56bb0d61623b35b08cc0',
      hash: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039',
      id: 12345
    )).to be_a Array }
  end

  describe '#transfers_outgoing' do
    it { expect(subject.transfers_outgoing(
      '68e4f79f886927de698df4f857de2aada41ccca6617e56bb0d61623b35b08cc0',
      hash: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039',
      id: 12345
    )).to be_a Array }
  end

  describe '#transfers_all' do
    it { expect(subject.transfers_all(
      '68e4f79f886927de698df4f857de2aada41ccca6617e56bb0d61623b35b08cc0',
      hash: '44e4968e5aa35fe182d4def5958e23cf941c4bf809364afb4431ebbf6a18c039',
      id: 12345
    )).to be_a Array }
  end
end
