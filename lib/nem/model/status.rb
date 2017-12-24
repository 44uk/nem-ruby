module Nem
  module Model
    class Status
      include Nem::Mixin::Assignable

      attr_reader :code,
        :type,
        :message

      # 0: Unknown status.
      # 1: NIS is stopped.
      # 2: NIS is starting.
      # 3: NIS is running.
      # 4: NIS is booting the local node (implies NIS is running).
      # 5: The local node is booted (implies NIS is running).
      # 6: The local node is synchronized (implies NIS is running and the local node is booted).
      # 7: NIS local node does not see any remote NIS node (implies running and booted).
      # 8: NIS is currently loading the block chain from the database. In this state NIS cannot serve any requests.
    end
  end
end
