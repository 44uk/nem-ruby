module Nem
  module Endpoint
    class Timesync < Nem::Endpoint::Base
      def network_time
        Nem::Model::NetworkTime.new_from_network_time request!(:get, '/time-sync/network-time')
      end
    end
  end
end
