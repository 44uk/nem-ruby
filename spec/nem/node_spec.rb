require 'spec_helper'

describe Nem::Node do
  subject { described_class.new }

  describe '#heartbeat' do
    it { expect(subject.heartbeat).to be_a Nem::Model::Heartbeat }
  end

  describe '#status' do
    it { expect(subject.status).to be_a Nem::Model::Status }
  end

  # describe '#shutdown' do
  #   it { expect(subject.shutdown).to be_a Nem::Model::Status }
  # end
end
