require 'spec_helper'

describe Nem::Mosaic::DimToken do
  subject { described_class.new(1) }
  it { expect(subject.mosaic_id).to be_a Nem::Model::MosaicId }
  it { expect(subject.fqn).to eq 'dim:token' }
  it { expect(subject.amount).to eq 1_000_000 }
end