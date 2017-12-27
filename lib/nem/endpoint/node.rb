module Nem
  module Endpoint
    class Node < Nem::Endpoint::Base
      # @return [integer]
      # @see https://nemproject.github.io/#maximum-chain-height-in-the-active-neighborhood
      def max_chain_height
        request!(:get, '/node/active-peers/max-chain-height')[:height]
      end

      # @return [Nem::Model::Node]
      # @see https://nemproject.github.io/#basic-node-information
      def info
        Nem::Model::Node.new_from_node request!(:get, '/node/info')
      end

      # @return [Nem::Model::NisNodeInfo]
      # @see https://nemproject.github.io/#extended-node-information
      def extended_info
        Nem::Model::NisNodeInfo.new_from_nis_node_info request!(:get, '/node/extended-info')
      end

      # @return [Nem::Model::ExtendedNodeExperiencePair]
      # @see https://nemproject.github.io/#requesting-node-experiences
      def experiences
        request!(:get, '/node/experiences') do |res|
          res[:data].map do |struct|
            Nem::Model::Experience.new_from_experience(struct)
          end
        end
      end

      # @return [Array <Nem::Model::Node>]
      # @see https://nemproject.github.io/#active-neighborhood
      def peerlist_active
        request!(:get, '/node/peer-list/active') do |res|
          res[:data].map do |n|
            Nem::Model::Node.new_from_node(n)
          end
        end
      end

      # @return [Struct]
      # @see https://nemproject.github.io/#complete-neighborhood
      PeerlistAll = Struct.new(:inactive, :failure, :busy, :active)
      def peerlist_all
        request!(:get, '/node/peer-list/all') do |res|
          PeerlistAll.new(
            res[:inactive].map { |n| Nem::Model::Node.new_from_node(n) },
            res[:failure].map { |n| Nem::Model::Node.new_from_node(n) },
            res[:busy].map { |n| Nem::Model::Node.new_from_node(n) },
            res[:active].map { |n| Nem::Model::Node.new_from_node(n) }
          )
        end
      end

      # @return [Array <Nem::Model::Node>]
      # @see https://nemproject.github.io/#reachable-neighborhood
      def peerlist_reachable
        request!(:get, '/node/peer-list/reachable') do |res|
          res[:data].map do |n|
            Nem::Model::Node.new_from_node(n)
          end
        end
      end

      # @param type [Symbol]
      # @return [Array <Nem::Model::Node>]
      def peerlist(type = :all)
        case type.to_s
        when /\Aactive/ then peerlist_active
        when /\Areach/ then peerlist_reachable
        else peerlist_all
        end
      end

      # @param boot_node_request [Nem::Model::BootNodeRequest]
      # @return [nil]
      # @see https://nemproject.github.io/#booting-the-local-node
      def boot(boot_node_request)
        request!(:post, '/node/boot', boot_node_request)
      end
    end
  end
end
