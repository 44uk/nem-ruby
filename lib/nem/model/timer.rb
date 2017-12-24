module Nem
  module Model
    class Timer
      include Nem::Mixin::Assignable

      attr_reader :last_delay_time,
        :executions,
        :failures,
        :successes,
        :last_operation_start_time,
        :is_executing,
        :name,
        :average_operation_time,
        :operation_time

      def self.new_from_timer(hash)
        new(
          last_delay_time: hash[:'last-delay-time'],
          executions: hash[:executions],
          failures: hash[:failures],
          successes: hash[:successes],
          last_operation_start_time: hash[:'last-operation-start-time'],
          is_executing: hash[:'is-executing'],
          name: hash[:name],
          average_operation_time: hash[:'average-operation-time'],
          operation_time: hash[:'operation-time']
        )
      end
    end
  end
end
