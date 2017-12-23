require 'spec_helper'

describe Nem::Mosaic::Xem do
  subject { described_class.new(1) }
  it { expect(subject).to be_a Nem::Model::MosaicAttachment }
  it { expect(subject.mosaic_id).to be_a Nem::Model::MosaicId }
  it { expect(subject.fqn).to eq 'nem:xem' }
  it { expect(subject.amount).to eq 1_000_000 }
end
