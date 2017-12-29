module Nem
  module Model
    class NodeMetadata
      include Nem::Mixin::Assignable

      attr_reader :features,
        :network,
        :application,
        :network_id,
        :version,
        :platform

      def self.new_from_metadata(hash)
        new(
          features: hash[:features],
          application: hash[:application],
          network_id: hash[:networkId],
          version: hash[:version],
          platform: hash[:platform]
        )
      end
    end

    class NodeEndpoint
      include Nem::Mixin::Assignable

      attr_reader :protocol, :port, :host

      def self.new_from_endpoint(hash)
        new(hash)
      end
    end

    class NodeIdentity
      include Nem::Mixin::Assignable

      attr_reader :name, :public_key

      def self.new_from_identity(hash)
        new(
          name: hash[:name],
          public_key: hash[:"public-key"]
        )
      end
    end

    class Node
      include Nem::Mixin::Assignable

      attr_reader :metadata,
        :endpoint,
        :identity

      def self.new_from_node(hash)
        new(
          metadata: NodeMetadata.new_from_metadata(hash[:metaData]),
          endpoint: NodeEndpoint.new_from_endpoint(hash[:endpoint]),
          identity: NodeIdentity.new_from_identity(hash[:identity])
        )
      end
    end
  end
end
