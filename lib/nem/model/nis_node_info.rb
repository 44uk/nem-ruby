module Nem
  module Model
    class NisInfo
      include Nem::Mixin::Assignable

      attr_reader :current_time,
        :application,
        :start_time,
        :version,
        :signer

      def self.new_from_nis_info(hash)
        new(
          current_time: hash[:currentTime],
          application: hash[:application],
          start_time: hash[:startTime],
          version: hash[:version],
          signer: hash[:signer]
        )
      end
    end

    class NisNodeInfo
      include Nem::Mixin::Assignable

      attr_reader :node, :nis_info

      def self.new_from_nis_node_info(hash)
        new(
          node: Node.new_from_node(hash[:node]),
          nis_info: NisInfo.new_from_nis_info(hash[:nisInfo])
        )
      end
    end
  end
end
