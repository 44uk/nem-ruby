module Nem
  module Model
    class TransferTransaction < Transaction
      attr_reader :recipient, :amount, :message, :mosaics

      def self.new_from_transaction_meta_data_pair(hash)
        transaction = hash[:transaction]
        attrs = common_part_meta_data_pair(hash).merge(
          recipient: transaction[:recipient],
          amount: transaction[:amount],
        )
        unless transaction[:message].empty?
          attrs[:message] = Nem::Model::Message.new_from_message(transaction[:message])
        end
        if transaction[:mosaics]
          attrs[:mosaics] = transaction[:mosaics].map do |mo|
            Mosaic.new_from_mosaic(mo)
          end
        end
        new(attrs)
      end
    end
  end
end
