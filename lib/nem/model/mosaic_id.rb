module Nem
  module Model
    class MosaicId
      include Nem::Mixin::Assignable

      attr_reader :namespace_id, :name

      def self.new_from_mosaic_id(hash)
        new(
          namespace_id: hash[:namespaceId],
          name: hash[:name]
        )
      end

      def fqn
        @fqn ||= "#{@namespace_id}:#{@name}"
      end

      def to_hash
        {
          namespaceId: namespace_id,
          name: name
        }
      end
    end
  end
end
