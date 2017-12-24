module Nem
  module Mosaic
    class DimCoin < Nem::Model::MosaicAttachment
      def initialize(quantity)
        mosaic_id = Nem::Model::MosaicId.new(
          namespace_id: 'dim',
          name: 'coin'
        )
        properties = Nem::Model::MosaicProperties.new(
          divisibility: 6,
          initial_supply: 900_000_000
        )
        super(
          mosaic_id: mosaic_id,
          properties: properties,
          quantity: quantity
        )
      end
    end
  end
end
