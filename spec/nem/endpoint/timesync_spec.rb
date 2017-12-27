require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Timesync do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#network_time' do
    it { expect(subject.network_time).to be_a Nem::Model::NetworkTime }
  end
end
