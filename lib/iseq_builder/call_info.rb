module ISeqBuilder
  class CallInfo
    attr_reader :mid, :flag, :orig_argc, :id
    def initialize(mid, flag, orig_argc, id)
      @mid = mid
      @flag = flag
      @orig_argc = orig_argc
      @id = id
    end

    def to_bin
      [@mid, @flag, @orig_argc].pack("QI2")
    end

    def to_s
      "<callinfo!mid: #{@mid}, flag: #{@flag}, orig_argc: #{@orig_argc}>"
    end

    def inspect
      self.to_s
    end
  end
end
