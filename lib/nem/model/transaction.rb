module Nem
  module Model
    class Transaction
      include Nem::Mixin::Assignable

      extend Forwardable
      def_delegators :@version, :version, :network

      attr_reader :timestamp,
        :version,
        :type,
        :signer,
        :fee,
        :deadline,
        :id,
        :hash,
        :height

      def self.new_from_account_transaction(hash)
        new_from_account_transaction_meta_data_pair(
          meta: { data: nil },
          transaction: hash
        )
      end

      def self.new_from_account_transaction_meta_data_pair(hash)
        type = hash[:transaction][:type]
        klass = case type
                when 0x0101 then TransferTransaction
                when 0x0801 then ImportanceTransferTransaction
                when 0x1001 then MultisigAggregateModificationTransaction
                when 0x1002 then MultisigSignatureTransaction
                when 0x1004 then MultisigTransaction
                when 0x2001 then ProvisionNamespaceTransaction
                when 0x4001 then MosaicDefinitionCreationTransaction
                when 0x4002 then MosaicSupplyChangeTransaction
          else raise "Undefined transaction type: #{type}"
        end
        klass.new_from_transaction_meta_data_pair(hash)
      end

      private

      def self.common_part(hash)
        {
          timestamp: Nem::Unit::Time.new_from_nemtime(hash[:timeStamp]),
          deadline: Nem::Unit::Time.new_from_nemtime(hash[:deadline]),
          fee: hash[:fee],
          type: hash[:type],
          version: Nem::Unit::Version.new(hash[:version]),
          signer: hash[:signer]
        }
      end

      def self.common_part_meta_data_pair(hash)
        meta = hash[:meta]
        common_part(hash[:transaction]).merge(
          id: meta[:id],
          hash: meta[:hash] ? meta[:hash][:data] : meta[:data],
          height: meta[:height]
        )
      end
    end
  end
end
