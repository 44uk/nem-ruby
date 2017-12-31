module Nem
  module Transaction
    # @attr [Array <Nem::Model::MultisigCosignatoryModification>] modifications
    # @attr [Interger] relative_change
    # @attr [Interger] min_cosignatories
    class MultisigAggregateModification < Nem::Transaction::Base
      TYPE = 0x1001 # 4097 (multisig aggregate modification transfer transaction)

      attr_reader :modifications, :relative_change, :min_cosignatories

      def initialize(modifications, relative_change, network: nil)
        @modifications = modifications
        @relative_change = relative_change

        @network = network || Nem.default_network
        @type = TYPE
        @fee = Nem::Fee::MultisigAggregateModification.new(self)
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
