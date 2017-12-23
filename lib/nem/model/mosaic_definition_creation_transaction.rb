module Nem
  module Model
    class MosaicDefinitionCreationTransaction < Transaction
      attr_reader :creation_fee, :creation_fee_sink, :mosaic_definition

      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        mo_def = MosaicDefinition.new_from_mosaic_definition(transaction[:mosaicDefinition])
        attrs = common_part_meta_data_pair(hash).merge(
          creation_fee: transaction[:creationFee],
          creation_fee_sink: transaction[:creationFeeSink],
          mosaic_definition: mo_def
        )
        new(attrs)
      end
    end
  end
end
