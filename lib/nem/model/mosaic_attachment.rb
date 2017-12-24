module Nem
  module Model
    class MosaicAttachment
      include Nem::Mixin::Assignable

      extend Forwardable

      def_delegators :@mosaic_id, :fqn
      def_delegators :@properties,
        :divisibility,
        :initial_supply,
        :supply_mutable,
        :transferable

      attr_reader :mosaic_id, :properties, :quantity

      def amount
        return quantity * (10**properties.divisibility)
      end
    end
  end
end
