require 'spec_helper'

class Nem::Mosaic::ExampleMosaic
  include Nem::Mixin::MosaicAttachable
  namespace_id 'example.foo'
  name 'bar'
  divisibility 3
  initial_supply 100_000_000
end

describe Nem::Mosaic::ExampleMosaic do
  subject { described_class.new(0.001) }
  it { expect(subject.mosaic_id).to be_a Nem::Model::MosaicId }
  it { expect(subject.fqn).to eq 'example.foo:bar' }
  it { expect(subject.amount).to eq 1 }
end
