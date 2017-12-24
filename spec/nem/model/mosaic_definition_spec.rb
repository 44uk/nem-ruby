require 'spec_helper'

describe Nem::Model::MosaicDefinition do
  describe '.new_from_mosaic_definition' do
    let(:hash) {
      {
        creator: 'be2ba9cb15a547110d511a4d43c0482fbb584d78781abac01fb053d18f4a0033',
        id: {
          namespaceId: 'sushi',
          name: 'maguro'
        },
        description: 'Japanese Soul food SHUSHI.',
        properties: {
          divisibility: 0,
          initialSupply: 10_000,
          supplyMutable: true,
          transferable: true
        },
        levy: {
          type: 1,
          recipient: 'TDPP2C4XQLMESBMCYGWN4NRAJAKZEYRV75KGYSOB',
          mosaicId: {
            namespaceId: 'nem',
            name: 'xem'
          },
          fee: 1_000
        }
      }
    }

    subject { described_class.new_from_mosaic_definition(hash) }

    xit { expect(subject).to be_a described_class }
  end
end
