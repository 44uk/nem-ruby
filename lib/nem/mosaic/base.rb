module Nem
  module Mosaic
    class Base < Nem::Model::MosaicAttachment
      extend Nem::Mixin::MosaicDefinition

      def initialize(quantity)
        mosaic_id = Nem::Model::MosaicId.new(
          namespace_id: namespace_id,
          name: name
        )
        properties = Nem::Model::MosaicProperties.new(
          divisibility: divisibility,
          initial_supply: initial_supply
        )
        super(
          mosaic_id: mosaic_id,
          properties: properties,
          quantity: quantity
        )
      end

      def namespace_id
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented."
      end

      def name
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented."
      end

      def divisibility
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented."
      end

      def initial_supply
        raise NotImplementedError, "#{self.class}##{__method__} must be implemented."
      end
    end
  end
end
