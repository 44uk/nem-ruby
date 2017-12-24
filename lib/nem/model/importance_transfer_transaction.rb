module Nem
  module Model
    class ImportanceTransferTransaction < Transaction
      attr_reader :mode, :remote_account

      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        attrs = common_part_meta_data_pair(hash).merge(
          mode: transaction[:mode],
          remote_account: transaction[:remoteAccount]
        )
        new(attrs)
      end
    end
  end
end
