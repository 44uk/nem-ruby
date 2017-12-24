module Nem
  class NodePool
    extend Forwardable

    def_delegators :@nodes, :first, :last, :length

    attr_reader :nodes, :failed

    def self.from_hash(definitions)
      new(definitions.map { |d| Nem::Node.new(d) })
    end

    def initialize(nodes)
      @nodes = nodes
      @failed = []
    end

    def current
      @nodes.first
    end

    def next!
      @failed << @nodes.shift
      raise 'Exhausted node pool' if length.zero?
    end

    def <<(definitioin)
      @nodes << Nem::Node.new(definitioin)
    end
  end
end
