module Nem
  module Model
    class NodeMetadata
      include Nem::Mixin::Assignable

      attr_reader :features,
        :network,
        :application,
        :version,
        :platform
    end

    class NodeEndpoint
      include Nem::Mixin::Assignable

      attr_reader :protocol, :port, :host
    end

    class NodeIdentity
      include Nem::Mixin::Assignable

      attr_reader :name, :public_key
    end

    class Node
      include Nem::Mixin::Assignable

      attr_reader :metadata,
        :endpoint,
        :identity

      def self.new_from_node(hash)
        new(
          metadata: NodeMetadata.new(hash[:metaData]),
          endpoint: NodeEndpoint.new(hash[:endpoint]),
          identity: NodeIdentity.new(hash[:identity])
        )
      end
    end
  end
end
