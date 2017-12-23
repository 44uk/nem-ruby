module Nem
  module Fee
    class MultisigAggregateModification
      def initialize(transaction)
        @transaction = transaction
      end

      # @return [Integer] fee in micro XEM
      def value
        if @transaction.min_cosignatories == 0
          0.5 * 1_000_000
        else
          0.5 * 1_000_000
        end
      end

      # @return [Integer] fee in micro XEM
      def to_i
        value.to_i
      end

      # @return [Boolean]
      def testnet?
        @transaction.network == :testnet
      end
    end
  end
end
