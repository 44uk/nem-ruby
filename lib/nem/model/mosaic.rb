module Nem
  module Model
    class Mosaic
      include Nem::Mixin::Assignable

      extend Forwardable

      def_delegators :@mosaic_id, :fqn

      attr_reader :mosaic_id, :quantity

      def self.new_from_mosaic(hash)
        mosaic_id = Nem::Model::MosaicId.new_from_mosaic_id(hash[:mosaicId])
        new(
          quantity: hash[:quantity],
          mosaic_id: mosaic_id
        )
      end
    end
  end
end
