module Nem
  module Model
    class Namespace
      include Nem::Mixin::Assignable

      attr_reader :id, :fqn, :owner, :height

      def self.new_from_namespace_meta_data_pair(hash)
        meta = hash[:meta]
        ns = hash[:namespace]
        new(
          id: meta[:id],
          fqn: ns[:fqn],
          owner: ns[:owner],
          height: ns[:height]
        )
      end

      def self.new_from_namespace(hash)
        new(hash)
      end
    end
  end
end
