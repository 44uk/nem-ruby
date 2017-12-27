module Nem
  module Endpoint
    class Namespace < Nem::Endpoint::Base
      # @return [Nem::Model::Namespace]
      # @see https://nemproject.github.io/#retrieving-a-specific-namespace
      def find(namespace)
        request!(:get, '/namespace', namespace: namespace) do |res|
          Nem::Model::Namespace.new_from_namespace(res)
        end
      end

      alias get find

      # @return [Array <Nem::Model::Namespace>]
      # @see https://nemproject.github.io/#retrieving-root-namespaces
      def root(id, page_size: nil)
        request!(:get, '/namespace/root/page', id: id, pageSize: page_size) do |res|
          res[:data].map do |nsmdp|
            Nem::Model::Namespace.new_from_namespace_meta_data_pair(nsmdp)
          end
        end
      end

      # @return [Array <Nem::Model::MosaicDefinition>]
      # @see https://nemproject.github.io/#retrieving-mosaic-definitions
      def mosaic_definition(namespace, id: nil, page_size: nil)
        request!(:get, '/namespace/mosaic/definition/page',
          namespace: namespace,
          id: id,
          pageSize: page_size
        ) do |res|
          res[:data].map { |mdmdp| Nem::Model::MosaicDefinition.new_from_mosaic_definition_meta_data_pair(mdmdp) }
        end
      end
    end
  end
end
