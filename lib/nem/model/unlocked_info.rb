module Nem
  module Model
    class UnlockedInfo
      include Nem::Mixin::Assignable

      attr_reader :max_unlocked, :num_unlocked

      def self.new_from_unlocked_info(hash)
        new(
          max_unlocked: hash[:'max-unlocked'],
          num_unlocked: hash[:'num-unlocked']
        )
      end

      def has_freeslot?
        ! @max_unlocked == @num_unlocked
      end

      def freeslot
        @max_unlocked - @num_unlocked
      end
    end
  end
end
