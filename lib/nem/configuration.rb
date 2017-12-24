require 'logger'

module Nem
  module Configuration
    DEADLINE = 3600

    # Logger for {#debug}, default is `Nem::Logger.new(STDOUT)`
    # @return [Logger]
    attr_accessor :logger, :deadline, :default_network

    def self.extended(base)
      base.logger = Logger.new($stdout).tap { |l| l.level = Logger::INFO }
      base.deadline = DEADLINE
      base.default_network = :testnet
    end

    # @yield [self]
    # @example
    #   Nem.configure do |conf|
    #     conf.logger = Logger.new('path/to/nem-ruby.log')
    #     conf.logger.level = Logger::DEBUG
    #     conf.deadline = 7200
    #     conf.default_network = :mainnet
    #   end
    def configure
      yield self
    end
  end
end
