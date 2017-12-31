module Nem
  module Transaction
    # @attr [Interger] modification_type
    # @attr [Interger] cosignatory_account
    class MultisigCosignatoryModification
      attr_reader :modification_type, :cosignatory_account

      TYPE_ADD = 0x001
      TYPE_REMOVE = 0x002

      def initialize(type, public_key)
        @modification_type = type
        @cosignatory_account = public_key
      end

      # attributes must be CAMEL CASE for NIS params
      # @return [Hash]
      def to_hash
        {
          modificationType: parse_type,
          cosignatoryAccount: cosignatory_account
        }
      end

      private

      def parse_type
        case modification_type
        when :add then TYPE_ADD
        when :remove then TYPE_REMOVE
          else raise "Not implemented mode: #{modification_type}"
        end
      end
    end
  end
end
