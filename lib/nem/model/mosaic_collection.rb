module Nem
  module Model
    class MosaicCollection
      include Enumerable
      extend Forwardable
      def_delegators :@attachments, :size, :empty?,
        :each, :map, :find, :sort_by

      attr_reader :attachments

      # @param [Array] attachments
      def initialize(attachments)
        @attachments = attachments
      end

      # @param [String] fqn
      # @return [Nem::Model::MosaicAttachment]
      def find_by_fqn(fqn)
        attachments.find { |a| a.fqn == fqn }
      end

      alias :[] :find_by_fqn

      # @param [String] namespace_id
      # @return [Nem::Model::MosaicCollection]
      def find_by_namespace_id(namespace_id)
        self.class.new(attachments.select { |a| a.namespace_id == namespace_id })
      end
    end
  end
end
