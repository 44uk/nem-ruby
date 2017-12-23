module Nem
  module Model
    class MultisigInfo
      include Nem::Mixin::Assignable

      attr_reader :cosignatories_count, :min_cosignatories

      def self.new_from_multisig_info(hash)
        new(
          cosignatories_count: hash[:cosignatoriesCount],
          min_cosignatories: hash[:minCosignatories]
        )
      end
    end
  end
end
