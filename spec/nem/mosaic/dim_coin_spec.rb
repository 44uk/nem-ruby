require 'spec_helper'

describe Nem::Mosaic::DimCoin do
  subject { described_class.new(1) }
  it { expect(subject).to be_a Nem::Model::MosaicAttachment }
  it { expect(subject.mosaic_id).to be_a Nem::Model::MosaicId }
  it { expect(subject.fqn).to eq 'dim:coin' }
  it { expect(subject.amount).to eq 1_000_000 }
end
