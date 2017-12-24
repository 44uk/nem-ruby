require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Chain do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#' do
  end
end
