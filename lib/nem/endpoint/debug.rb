module Nem
  module Endpoint
    class Debug < Nem::Endpoint::Base
      def time_syncronization
        request!(:get, '/debug/time-synchronization') do |res|
          res[:data].map do |sync|
            Nem::Model::Timesync.new_from_timer(sync)
          end
        end
      end

      def timers
        request!(:get, '/debug/timers') do |res|
          res[:data].map do |timer|
            Nem::Model::Timer.new_from_timer(timer)
          end
        end
      end

      Connection = Struct.new(:outstanding, :most_recent)
      def connections_incoming
        request!(:get, '/debug/connections/incoming') do |res|
          outstanding = res[:outstanding].map do |con|
            Nem::Model::Connection.new_from_connection(con)
          end
          most_recent = res[:'most-recent'].map do |con|
            Nem::Model::Connection.new_from_connection(con)
          end
          Connection.new(outstanding, most_recent)
        end
      end

      def connections_outgoing
        request!(:get, '/debug/connections/outgoing') do |res|
          outstanding = res[:outstanding].map do |con|
            Nem::Model::Connection.new_from_connection(con)
          end
          most_recent = res[:'most-recent'].map do |con|
            Nem::Model::Connection.new_from_connection(con)
          end
          Connection.new(outstanding, most_recent)
        end
      end

      def connections(dir)
        case dir.to_s
        when /\Ain/  then connections_incoming
        when /\Aout/ then connections_outgoing
        else raise "direction should be :incoming or :outgoing. dir: #{dir}"
        end
      end
    end
  end
end
