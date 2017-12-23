module Nem
  module Model
    class MosaicSupplyChangeTransaction < Transaction
      attr_reader :supply_type, :delta, :mosaic_id

      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        mo_id = MosaicId.new_from_mosaic_id(transaction[:mosaicId])
        attrs = common_part_meta_data_pair(hash).merge(
          supply_type: transaction[:supplyType],
          delta: transaction[:delta],
          mosaic_id: mo_id
        )
        new(attrs)
      end
    end
  end
end
