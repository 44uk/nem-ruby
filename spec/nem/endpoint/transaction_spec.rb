require 'spec_helper'
require 'webmock_helper'

describe Nem::Endpoint::Transaction do
  let(:node) { Nem::Node.new }
  let(:endpoint) { described_class.new(node) }

  subject { endpoint }

  describe '#find' do
    it { expect(subject.find('37c34ead4c3fe6af42d994135798262f785ba2d807c02ac3608bc10da12e5f87')).to be_a Nem::Model::Transaction }
  end
end
