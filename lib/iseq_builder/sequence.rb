module ISeqBuilder
  class Sequence
    attr_reader :insns

    def initialize(builder, type = ISeqBuilder::ISEQ_TYPE_TOP)
      @builder = builder
      @type = type
      @insns = []
      @call_info = []
    end

    def <<(insn)
      @insns << insn
    end

    def string(str)
      @builder.object(T_STRING, false, true, false, str)
    end

    def call_info(symbol, flags, orig_arg)
      @builder.identifiable_object(T_STRING, false, true, false, symbol.to_s)
      @call_info << call_info = CallInfo.new(ID_STATIC_SYM, flags, orig_arg, @call_info.size)
      call_info
    end

    def to_bin
      bin = ""
      @insns.each do |insn|
        bin << insn.to_bin
      end

      @call_info.each do |ci_entry|
        bin << ci_entry.to_bin
      end

      bin
    end

    def constant_body(offset)
      ISeqConstantBody.new(@type, offset, @insns, @call_info)
    end

    def inspect
<<STR
== #{@type} ======================
#{@insns.map{|insn| insn.inspect}.join("\n")}
STR
    end
  end
end
