module Nem
  module Model
    class MosaicSupply
      include Nem::Mixin::Assignable

      extend Forwardable

      def_delegators :@id, :namespace_id, :name

      attr_reader :id, :supply

      def self.new_from_mosaic_supply(hash)
        id = Nem::Model::MosaicId.new_from_mosaic_id(hash[:mosaicId])
        new(
          id: id,
          supply: hash[:supply]
        )
      end
    end
  end
end
