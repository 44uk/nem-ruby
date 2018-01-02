module Nem
  module Transaction
    # @attr [Nem::Model::MosaicId] mosaic_id
    # @attr [Symbol] supply_type
    # @attr [Integer] delta
    # @see https://nemproject.github.io/#mosaicSupplyChangeTransaction
    class MosaicSupplyChange < Base
      TYPE = 0x4002 # 16386 (mosaic supply change transaction)

      INCREASE = 0x0001
      DECREASE = 0x0002

      attr_accessor :mosaic_id, :supply_type, :delta

      def initialize(mosaic_id, type, delta, network: nil)
        @mosaic_id = mosaic_id
        @supply_type = type
        @delta = delta

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::MosaicSupplyChangeTransfer.new(self)
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          mosaicId: mosaic_id.to_hash,
          supplyType: parse_type,
          delta: delta,
        }
      end

      private

      def parse_type
        case type
        when :increase  then INCREASE
        when :descrease then DECREASE
          else raise "Not implemented type: #{type}"
        end
      end
    end
  end
end
