module Nem
  module Model
    class NetworkTime
      include Nem::Mixin::Assignable

      attr_reader :send_timestamp, :receive_timestamp

      def self.new_from_network_time(hash)
        new(
          send_timestamp: hash[:sendTimeStamp],
          receive_timestamp: hash[:receiveTimeStamp]
        )
      end
    end
  end
end
