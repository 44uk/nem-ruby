require 'spec_helper'

describe Nem::Mosaic::EcobitEco do
  subject { described_class.new(1_000) }
  it { expect(subject).to be_a Nem::Model::MosaicAttachment }
  it { expect(subject.mosaic_id).to be_a Nem::Model::MosaicId }
  it { expect(subject.fqn).to eq 'ecobit:eco' }
  it { expect(subject.amount).to eq 1_000 }
end
