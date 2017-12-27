module Nem
  module Endpoint
    class Timesync < Nem::Endpoint::Base
      # @return [Nem::Model::NetworkTime]
      def network_time
        Nem::Model::NetworkTime.new_from_network_time request!(:get, '/time-sync/network-time')
      end
    end
  end
end
