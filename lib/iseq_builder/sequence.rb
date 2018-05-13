module ISeqBuilder
  class Sequence
    attr_reader :insns, :insns_info, :local_table, :call_info, :label_table

    def initialize(builder, type = ISeqBuilder::ISEQ_TYPE_TOP)
      @builder = builder
      @type = type
      @local_table = []
      @insns = []
      @insns_info = []
      @call_info = []
      @label_table = {}
    end

    def <<(insn)
      @insns << insn
    end

    def insn(opcode, *operand)
      Insn.new(self, opcode, *operand)
    end

    def event(lineno, event)
      @insns_info << InsnsInfo.new(@insns.length, lineno, event)
    end

    def pc
      @insns.sum(&:size)
    end

    def label(label)
      @label_table[label] = pc
    end

    def string(str)
      @builder.object(T_STRING, false, true, false, str)
    end

    def integer(i)
      @builder.object(T_UNDEF, true, true, true, i * 2 + 1)
    end

    def callinfo(symbol, orig_arg, flags)
      mid = find_id_index(symbol)
      mid = @builder.identifiable_object(T_STRING, false, true, false, symbol.to_s) unless mid
      @call_info << call_info = CallInfo.new(mid, flags, orig_arg, @call_info.size)
      call_info
    end

    def local(symbol)
      local_idx = find_local_index(symbol)
      return local_idx + 1 if local_idx
      idx = @builder.identifiable_object(T_STRING, false, true, false, symbol.to_s)
      @local_table << idx
      @local_table.length
    end

    def constant(symbol)
      idx = find_id_index(symbol)
      return idx if idx
      @builder.identifiable_object(T_STRING, false, true, false, symbol.to_s)
    end

    def find_local_index(symbol)
      @local_table.find_index do |idx|
        id = @builder.id_list[idx]
        object = @builder.objects[id]
        object.type == T_STRING && object.value == symbol.to_s
      end
    end

    def find_id_index(symbol)
      @builder.id_list.find_index do |id|
        object = @builder.objects[id]
        object.type == T_STRING && object.value == symbol.to_s
      end
    end

    def method_missing(name, *args)
      if INSN_TYPE.include?(name)
        @insns << insn(name, *args)
      else
        super
      end
    end

    def to_bin
      bin = ""
      @insns.each do |insn|
        bin << insn.to_bin
      end

      @insns_info.each do |info|
        bin << info.to_bin
      end

      bin << @local_table.pack("Q*")

      @call_info.each do |ci_entry|
        bin << ci_entry.to_bin
      end

      bin
    end

    def constant_body(offset)
      ISeqConstantBody.new(self, @type, offset)
    end

    def inspect
<<STR
== #{@type} ======================
#{@insns.map{|insn| insn.inspect}.join("\n")}
STR
    end
  end
end
