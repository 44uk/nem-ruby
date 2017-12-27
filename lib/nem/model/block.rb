module Nem
  module Model
    class Block
      include Nem::Mixin::Assignable

      attr_reader :timestamp,
        :signature,
        :prev_block_hash,
        :type,
        :transactions,
        :version,
        :signer,
        :height

      def self.new_from_block(hash)
        txes = hash[:transactions].map do |tx|
          Transaction.new_from_account_transaction(tx)
        end
        new(
          timestamp: hash[:timeStamp],
          signature: hash[:signature],
          prev_block_hash: hash[:prevBlockHash][:data],
          type: hash[:type],
          transactions: txes,
          version: hash[:version],
          signer: hash[:signer],
          height: hash[:height]
        )
      end
    end
  end
end
