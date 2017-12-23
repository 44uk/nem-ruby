module Nem
  class Node
    extend Forwardable

    def_delegators :@client, :request, :request!

    # @param [hash] options HTTP Client connection information
    # @option options [String] :url URL
    # @option options [String] :scheme default http
    # @option options [Symbol] :host default 127.0.0.1
    # @option options [Integer] :port default 7890
    # @option options [Integer] :timeout default 5
    def initialize(options = {})
      @client = Nem::Client.new(options)
    end

    def heartbeat
      Nem::Model::Heartbeat.new request!(:get, '/heartbeat')
    end

    def status
      Nem::Model::Status.new request!(:get, '/status')
    end

    def shutdown
      request!(:get, '/shutdown')
    end
  end
end
