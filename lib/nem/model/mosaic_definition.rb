module Nem
  module Model
    class MosaicDefinition
      include Nem::Mixin::Assignable

      extend Forwardable

      def_delegators :@properties,
        :divisibility,
        :initial_supply,
        :supply_mutable,
        :transferable

      attr_reader :creator,
        :id,
        :description,
        :properties,
        :levy,
        :meta_id

      def self.new_from_mosaic_definition(hash)
        id = MosaicId.new_from_mosaic_id(hash[:id])
        props = MosaicProperties.new_from_mosaic_properties(hash[:properties])
        levy = MosaicLevy.new_from_mosaic_levy(hash[:levy])
        new(
          creator: hash[:creator],
          description: hash[:description],
          id: id,
          properties: props,
          levy: levy
        )
      end

      def self.new_from_mosaic_definition_meta_data_pair(hash)
        meta = hash[:meta]
        mosaic = hash[:mosaic]
        id = MosaicId.new_from_mosaic_id(mosaic[:id])
        props = MosaicProperties.new_from_mosaic_properties(mosaic[:properties])
        levy = MosaicLevy.new_from_mosaic_levy(mosaic[:levy])
        new(
          meta_id: meta[:id],
          creator: mosaic[:creator],
          description: mosaic[:description],
          id: id,
          properties: props,
          levy: levy
        )
      end

      def has_levy?
        ! @levy.empty?
      end

      def to_hash
        {
          creator: creator,
          id: id.to_hash,
          description: description,
          properties: properties.to_hash,
          levy: levy.to_hash
        }
      end
    end
  end
end
