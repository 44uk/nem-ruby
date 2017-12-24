module Nem
  module Model
    class NemAnnounceResult
      include Nem::Mixin::Assignable

      attr_reader :type, :code, :message, :transaction_hash, :inner_transaction_hash

      def self.new_from_nem_announce_result(hash)
        new(
          type: hash[:type],
          code: hash[:code],
          message: hash[:message],
          transaction_hash: hash[:transactionHash][:data],
          inner_transaction_hash: hash[:innerTransactionHash][:data]
        )
      end
    end
  end
end
