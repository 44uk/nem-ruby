module Nem
  module Model
    class ProvisionNamespaceTransaction < Transaction
      attr_reader :rental_fee, :rental_fee_sink, :parent, :new_part

      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        attrs = common_part_meta_data_pair(hash).merge(
          rental_fee: transaction[:rentalFee],
          rental_fee_sink: transaction[:rentalFeeSink],
          parent: transaction[:parent],
          new_part: transaction[:newPart]
        )
        new(attrs)
      end
    end
  end
end
