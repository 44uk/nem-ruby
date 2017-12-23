module Nem
  module Mosaic
    class DimToken < Nem::Model::MosaicAttachment
      def initialize(quantity)
        mosaic_id = Nem::Model::MosaicId.new(
          namespace_id: 'dim',
          name: 'token'
        )
        properties = Nem::Model::MosaicProperties.new(
          divisibility: 6,
          initial_supply: 1_000_000
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
