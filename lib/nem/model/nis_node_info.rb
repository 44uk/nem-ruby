module Nem
  module Model
    class NisInfo
      include Nem::Mixin::Assignable

      attr_reader :current_time,
        :application,
        :start_time,
        :version,
        :signer
    end

    class NisNodeInfo
      include Nem::Mixin::Assignable

      attr_reader :node, :nis_info

      def self.new_from_nis_node_info(hash)
        new(
          node: Node.new_from_node(hash[:node]),
          nis_info: NisInfo.new(hash[:nisInfo])
        )
      end
    end
  end
end
