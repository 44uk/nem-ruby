module Nem
  module Transaction
    # @attr [Integer] amount
    # @attr [String] recipient
    # @attr [Nem::Model::Message] message
    # @attr [Array <Nem::Model::MosaicId>] mosaics
    # @see https://nemproject.github.io/#transferTransaction
    # @see https://nemproject.github.io/#initiating-a-transfer-transaction
    # @see https://nemproject.github.io/#version-1-transfer-transactions
    # @see https://nemproject.github.io/#version-2-transfer-transactions
    class Transfer < Base
      TYPE = 0x0101 # 257 (transfer transaction)

      attr_reader :amount, :recipient, :message, :mosaics

      def initialize(recipient, amount, message = '', mosaics: [], timestamp: nil, deadline: nil, network: nil)
        @amount = amount
        @recipient = recipient
        @message = message.is_a?(Nem::Model::Message) ?
          message :
          Nem::Model::Message.new(message.to_s)
        @mosaics = mosaics

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::Transfer.new(self)
        @timestamp = timestamp || Time.now
        @deadline = deadline || Time.now + Nem.default_deadline
      end

      # @return [Boolean]
      def has_message?
        message.bytesize > 0
      end

      # @return [Boolean]
      def has_mosaics?
        mosaics.size > 0
      end

      def version
        network(hex: true) + (has_mosaics? ? 2 : 1)
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      # Mosaics need to be sorted by fqn. if not it will occur FAILURE_SIGNATURE_NOT_VERIFIABLE
      def to_hash
        tmp = {
          amount: amount * 1_000_000,
          recipient: recipient,
          message: message.to_hash
        }
        unless mosaics.empty?
          tmp[:mosaics] = mosaics
            .sort_by { |mo| mo.fqn }
            .map do |moa|
            {
              mosaicId: {
                namespaceId: moa.mosaic_id.namespace_id,
                name: moa.mosaic_id.name,
              },
              quantity: moa.amount.to_i
            }
          end
        end
        tmp
      end
    end
  end
end
