module Nem
  module Model
    class Timesync
      include Nem::Mixin::Assignable

      attr_reader :datetime,
        :current_time_offset,
        :change

      def self.new_from_timer(hash)
        new(
          datetime: hash[:datetime],
          current_time_offset: hash[:current_time_offset],
          change: hash[:change]
        )
      end
    end
  end
end
