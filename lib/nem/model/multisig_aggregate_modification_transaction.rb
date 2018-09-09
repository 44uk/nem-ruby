module Nem
  module Model
    class MultisigAggregateModificationTransaction < Transaction
      attr_reader :min_cosignatories, :relative_change, :modifications

      Modification = Struct.new(:modification_type, :cosignatory_account)
      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        modifications = transaction[:modifications].map do |mod|
          Modification.new(mod[:modificationType], mod[:cosignatoryAccount])
        end
        attrs = common_part_meta_data_pair(hash).merge(
          min_cosignatories: transaction[:minCosignatories],
          modifications: modifications
        )
        new(attrs)
      end
    end
  end
end
