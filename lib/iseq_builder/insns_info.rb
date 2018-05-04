module ISeqBuilder
  class InsnsInfo
    def initialize(position, lineno, events)
      @position = position
      @lineno = lineno
      @events = events
    end

    def to_bin
      [@position, @lineno, @events].pack("I*")
    end

    def to_s
      "position: #{@position}, lineno: #{@lineno}, events: #{@events}"
    end

    def inspect
      self.to_s
    end
  end
end
