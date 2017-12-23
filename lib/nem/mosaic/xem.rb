module Nem
  module Mosaic
    class Xem < Nem::Model::MosaicAttachment
      def initialize(quantity)
        mosaic_id = Nem::Model::MosaicId.new(
          namespace_id: 'nem',
          name: 'xem'
        )
        properties = Nem::Model::MosaicProperties.new(
          divisibility: 6,
          initial_supply: 8_999_999_999
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
