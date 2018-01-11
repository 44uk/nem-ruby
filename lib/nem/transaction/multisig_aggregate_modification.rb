module Nem
  module Transaction
    # @attr [Array <Nem::Model::MultisigCosignatoryModification>] modifications
    # @attr [Interger] relative_change
    # @attr [Interger] min_cosignatories
    class MultisigAggregateModification < Base
      TYPE = 0x1001 # 4097 (multisig aggregate modification transfer transaction)

      attr_reader :modifications, :relative_change, :min_cosignatories

      def initialize(modifications, relative_change, timestamp: nil, deadline: nil, network: nil)
        @modifications = modifications
        @relative_change = relative_change

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::MultisigAggregateModification.new(self)
        @timestamp = timestamp || Time.now
        @deadline = deadline || Time.now + Nem.default_deadline
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          modifications: modifications.map(&:to_hash),
          minCosignatories: {
            relativeChange: relative_change
          }
        }
      end
    end
  end
end
