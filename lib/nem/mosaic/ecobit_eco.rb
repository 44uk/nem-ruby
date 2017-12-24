module Nem
  module Mosaic
    class EcobitEco < Nem::Model::MosaicAttachment
      def initialize(quantity)
        mosaic_id = Nem::Model::MosaicId.new(
          namespace_id: 'ecobit',
          name: 'eco'
        )
        properties = Nem::Model::MosaicProperties.new(
          divisibility: 0,
          initial_supply: 888_888_888
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
