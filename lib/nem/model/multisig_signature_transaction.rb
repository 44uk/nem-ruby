module Nem
  module Model
    class MultisigSignatureTransaction < Transaction
      include Nem::Mixin::Assignable

      attr_reader :other_hash, :other_account

      def self.new_from_multisig_signature(hash)
        attrs = common_part(hash).merge(
          other_hash: hash[:otherHash][:data],
          other_account: hash[:otherAccount]
        )
        new(attrs)
      end
    end
  end
end
