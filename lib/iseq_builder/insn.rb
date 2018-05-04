module ISeqBuilder
  class Insn
    attr_reader :opcode, :operand

    def initialize(opcode, *operand)
      @opcode = opcode
      @operand = operand
    end

    def size
      1 + operand.size
    end

    def to_bin
      [INSNS_DEF[opcode], operand.map(&self.method(:operand_to_i))].flatten.pack("Q*")
    end

    def operand_to_i(operand)
      case operand
      when ISeqBuilder::ISeqObject
        operand.id
      when ISeqBuilder::CallInfo
        operand.id
      else
        operand
      end
    end

    def inspect
      "#{@opcode}\t#{@operand.map(&:to_s).join("\t")}"
    end

    INSNS_DEF = {
      getconstant: 11,
      putself: 16,
      putobject: 17,
      putstring: 20,
      pop: 33,
      dupn: 35,
      opt_send_without_block: 52,
      leave: 55,
      getinlinecache: 62,
      setinlinecache: 63,
      opt_plus: 66,
      opt_mod: 70,
      opt_aref: 78,
      opt_aset: 79,
      getlocal_OP__WC__0: 92,
      setlocal_OP__WC__0: 94,
      putobject_OP_INT2FIX_O_0_C_: 96,
    }
  end
end
