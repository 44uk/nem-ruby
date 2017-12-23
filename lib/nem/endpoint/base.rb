module Nem
  module Endpoint
    class Base
      def initialize(node)
        @node = if node.is_a?(Nem::NodePool)
          node
        else
          Nem::NodePool.new([node])
        end
      end

      def current_node
        @node.first
      end

      def next_node!
        @node.next!
      end

      def request(method, path, params = {})
        begin
          res = current_node.request(method, path, params)
          block_given? ? yield(res) : res
        rescue Faraday::ConnectionFailed => err
          Nem.logger.error err.message
          next_node!
          retry
        end
      end

      def request!(method, path, params = {})
        begin
          res = current_node.request!(method, path, params)
          block_given? ? yield(res) : res
        rescue Faraday::ConnectionFailed => err
          Nem.logger.error err.message
          next_node!
          retry
        rescue => err
          raise err
        end
      end
    end
  end
end
