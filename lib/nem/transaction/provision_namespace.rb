module Nem
  module Transaction
    # @attr [String] new_part
    # @attr [String] parent
    # @attr [String] rental_fee_sink
    # @attr [Integer] rental_fee
    class ProvisionNamespace < Base
      TYPE = 0x2001 # 8193 (provision namespace transaction)

      attr_reader :new_part, :parent, :rental_fee_sink, :rental_fee

      def initialize(new_part, parent = nil, timestamp: nil, deadline: nil, network: nil)
        @new_part = new_part
        @parent = parent
        @rental_fee = rental[:fee]
        @rental_fee_sink = rental[:sink]

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::ProvisionNamespace.new(self)
        @timestamp = timestamp || Time.now
        @deadline = deadline || Time.now + Nem.default_deadline
      end

      # @return [Boolean]
      def root?
        !!(@parent == nil)
      end

      # @return [Boolean]
      def sub?
        !!(@parent && @new_part)
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          newPart: new_part,
          parent: parent,
          rentalFeeSink: rental_fee_sink,
          rentalFee: rental_fee
        }
      end

      private

      # @see http://www.nem.ninja/docs/#namespaces
      def rental
        if @network == :mainnet
          if root?
            { fee: 100 * 1_000_000,
              sink: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA' }
          else
            { fee: 10 * 1_000_000,
              sink: 'NAMESPACEWH4MKFMBCVFERDPOOP4FK7MTBXDPZZA' }
          end
        else
          if root?
            { fee: 100 * 1_000_000,
              sink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35' }
          else
            { fee: 10 * 1_000_000,
              sink: 'TAMESPACEWH4MKFMBCVFERDPOOP4FK7MTDJEYP35' }
          end
        end
      end
    end
  end
end
