require 'spec_helper'

class Nem::Mosaic::ExampleFooBar < Nem::Model::MosaicAttachment
  def initialize(quantity)
    mosaic_id = Nem::Model::MosaicId.new(
      namespace_id: 'example.foo',
      name: 'bar'
    )
    properties = Nem::Model::MosaicProperties.new(
      divisibility: 3,
      initial_supply: 100_000_000
    )
    super(
      mosaic_id: mosaic_id,
      properties: properties,
      quantity: quantity
    )
  end
end

describe Nem::Mosaic::ExampleFooBar do
  subject { described_class.new(0.001) }
  it { expect(subject).to be_a Nem::Model::MosaicAttachment }
  it { expect(subject.mosaic_id).to be_a Nem::Model::MosaicId }
  it { expect(subject.fqn).to eq 'example.foo:bar' }
  it { expect(subject.amount).to eq 1 }
end
