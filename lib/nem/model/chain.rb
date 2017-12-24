module Nem
  module Model
    class Chain
      include Nem::Mixin::Assignable

      attr_reader :timestamp,

      def self.new_from_hash(hash)
        new(
        )
      end
    end
  end
end
