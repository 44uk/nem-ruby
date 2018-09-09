module Nem
  module Transaction
    # @attr [Array <Nem::Model::MultisigCosignatoryModification>] modifications
    # @attr [Interger] relative_change
    # @attr [Interger] min_cosignatories
    class MultisigAggregateModification < Base
      TYPE = 0x1001 # 4097 (multisig aggregate modification transfer transaction)

      attr_reader :modifications, :relative_change, :min_cosignatories

      def initialize(modifications, relative_change = 0, timestamp: nil, deadline: nil, network: nil)
        @modifications = modifications
        @relative_change = relative_change

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::MultisigAggregateModification.new(self)
        @timestamp = timestamp || Time.now
        @deadline = deadline || Time.now + Nem.default_deadline
      end

      def has_relative_change?
        relative_change != 0
      end

      def version
        network(hex: true) + (has_relative_change? ? 2 : 1)
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      # Modifications need to be sorted by address.
      # if not it will occur FAILURE_SIGNATURE_NOT_VERIFIABLE
      def to_hash
        tmp = {
          minCosignatories: {
            relativeChange: relative_change
          }
        }
        tmp[:modifications] = modifications
          .sort_by { |mo| Nem::Unit::Address.from_public_key(mo.cosignatory_account) }
          .map(&:to_hash)
        tmp
      end
    end
  end
end
