module Nem
  module Transaction
    # @attr [Nem::Transaction::*] other_trans
    # @attr [String] signer
    # @see https://nemproject.github.io/#multisigTransaction
    class Multisig < Base
      TYPE = 0x1004 # 4100 (multisig transaction)

      attr_reader :other_trans, :signer

      def initialize(trans, signer, timestamp: nil, deadline: nil, network: nil)
        @other_trans = trans
        @signer = signer

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::Multisig.new(self)
        @timestamp = timestamp || Time.now
        @deadline = deadline || Time.now + Nem.default_deadline
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          otherTrans: other_trans.to_hash,
          signer: signer
        }
      end
    end
  end
end
