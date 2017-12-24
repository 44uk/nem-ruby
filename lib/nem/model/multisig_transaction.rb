module Nem
  module Model
    class MultisigTransaction < Transaction
      attr_reader :other_trans, :signatures

      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        signs = transaction[:signatures].map do |sign|
          MultisigSignatureTransaction.new_from_multisig_signature(sign)
        end
        other = transaction[:otherTrans]
        other_trans = new_from_account_transaction(other)
        attrs = common_part_meta_data_pair(hash).merge(
          signatures: signs,
          other_trans: other_trans
        )
        new(attrs)
      end
    end
  end
end
