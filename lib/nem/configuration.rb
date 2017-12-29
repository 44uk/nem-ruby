require 'logger'

module Nem
  module Configuration
    DEADLINE = 3600

    attr_accessor :logger, :deadline, :default_network, :debug

    def self.extended(base)
      base.logger = Logger.new($stdout).tap { |l| l.level = Logger::INFO }
      base.deadline = DEADLINE
      base.default_network = :testnet
      base.debug = false
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
