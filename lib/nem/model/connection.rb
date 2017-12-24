module Nem
  module Model
    class Connection
      include Nem::Mixin::Assignable

      attr_reader:path,
        :start_time,
        :host,
        :elapsed_time,
        :id

      def self.new_from_connection(hash)
        new(
          path: hash[:path],
          start_time: hash[:"start-time"],
          host: hash[:host],
          elapsed_time: hash[:"elapsed-time"],
          id: hash[:id]
        )
      end
    end
  end
end
