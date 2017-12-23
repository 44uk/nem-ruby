require 'spec_helper'

describe Nem::Fee::MosaicDefinitionCreation do
  let(:mosaic_definition) {
    mosaic_id = Nem::Model::MosaicId.new(
      namespace_id: 'sushi',
      name: 'maguro'
    )
    properties = Nem::Model::MosaicProperties.new(
      divisibility: 0,
      initial_supply: 10_000,
      supply_mutable: true,
      transferable: true
    )
    levy = Nem::Model::MosaicLevy.new(
      type: 1,
      recipient: 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB',
      mosaic_id: Nem::Model::MosaicId.new(
        namespace_id: 'nem',
        name: 'xem'
      ),
      fee: 1_000
    )
    Nem::Model::MosaicDefinition.new(
      creator: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
      id: mosaic_id,
      description: 'Japanese Soul food SHUSHI.',
      properties: properties,
      levy: levy
    )
  }
  let(:network) { :testnet }
  let(:tx) do
    Nem::Transaction::MosaicDefinitionCreation.new(
      mosaic_definition,
      network: network
    )
  end
  let(:fee) { described_class.new(tx) }

  subject { fee.to_i }

  it { is_expected.to eq 10_000_000 }

  context 'on mainnet' do
    let(:network) { :mainnet }
    it { is_expected.to eq 10_000_000 }
  end
end
