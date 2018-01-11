module Nem
  module Unit
    class Time
      NEM_EPOCH = ::Time.utc(2015, 3, 29, 0, 6, 25, 0)

      def initialize(value)
        @value = value
      end

      def +(other)
        self.class.new(@value + other)
      end

      def -(other)
        self.class.new(@value - other)
      end

      def to_i
        (@value - NEM_EPOCH).to_i
      end

      def to_time
        @value.to_time
      end

      def self.parse(datetime)
        new(::Time.parse(datetime))
      end

      def self.now
        new(::Time.now.utc)
      end

      def self.new_from_nemtime(nemtime)
        new(NEM_EPOCH + nemtime)
      end
    end
  end
end
