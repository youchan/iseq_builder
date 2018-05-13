require "iseq_builder"

module BF
  class ISeqCompiler
    include ISeqBuilder

    def initialize
      @builder = ISeqBuilder.builder
      @sequence = @builder.top_level

      @label_num = 0
      @until_stack = []

      @sequence.instance_eval do
        getinlinecache :INLINECACHE, 0
        getconstant constant(:Array)
        setinlinecache :INLINECACHE
        label(:INLINECACHE)
        putobject integer(30000)
        putobject_OP_INT2FIX_O_0_C_
        opt_send_without_block callinfo(:new, 2, ARGS_SIMPLE), 0
        setlocal_OP__WC__0 local(:data)
        putobject_OP_INT2FIX_O_0_C_
        setlocal_OP__WC__0 local(:ptr)
      end
    end

    def compile_char(ch)
      case ch
      when ?.
        print
      when ?,
        # 
      when ?[
        @until_stack.push until_0
      when ?]
        until_end(*@until_stack.pop)
      end
    end

    def compile_char_opt(ch, n)
      case ch
      when ?>
        inc_ptr n
      when ?<
        dec_ptr n
      when ?+
        inc_data n
      when ?-
        dec_data n
      end
    end

    def inc_ptr(n)
      @sequence.instance_eval do
        getlocal_OP__WC__0 local(:ptr)
        putobject integer(n)
        opt_plus callinfo(:+, 1, ARGS_SIMPLE), 0
        setlocal_OP__WC__0 local(:ptr)
      end
    end

    def dec_ptr(n)
      @sequence.instance_eval do
        getlocal_OP__WC__0 local(:ptr)
        putobject integer(n)
        opt_minus callinfo(:-, 1, ARGS_SIMPLE), 0
        setlocal_OP__WC__0 local(:ptr)
      end
    end

    def inc_data(n)
      @sequence.instance_eval do
        getlocal_OP__WC__0 local(:data)
        getlocal_OP__WC__0 local(:ptr)
        dupn 2
        opt_aref callinfo(:[], 1, ARGS_SIMPLE), 0
        putobject integer(n)
        opt_plus callinfo(:+, 1, ARGS_SIMPLE), 0
        opt_aset callinfo(:[]=, 2, ARGS_SIMPLE), 0
        pop
      end
    end

    def dec_data(n)
      @sequence.instance_eval do
        getlocal_OP__WC__0 local(:data)
        getlocal_OP__WC__0 local(:ptr)
        dupn             2
        opt_aref callinfo(:[], 1, ARGS_SIMPLE), 0
        putobject integer(n)
        opt_minus callinfo(:-, 1, ARGS_SIMPLE), 0
        opt_aset callinfo(:[]=, 2, ARGS_SIMPLE), 0
        pop
      end
    end

    def print
      @sequence.instance_eval do
        putself
        putstring string("%c")
        getlocal_OP__WC__0 local(:data)
        getlocal_OP__WC__0 local(:ptr)
        opt_aref callinfo(:[], 1, ARGS_SIMPLE), 0
        opt_mod callinfo(:%, 1, ARGS_SIMPLE), 0
        opt_send_without_block callinfo(:print, 1, FCALL|ARGS_SIMPLE), 0
        pop
      end
    end

    def leave
      @sequence.instance_eval do
        getlocal_OP__WC__0 local(:ptr)
        leave
      end
    end

    def until_0
      l1 = :"L#{@label_num}"
      @label_num += 1
      l2 = :"L#{@label_num}"
      @label_num += 1

      @sequence.instance_eval do
        jump       l1
        label(l2)
      end
      [l1, l2]
    end

    def until_end(l1, l2)
      @sequence.instance_eval do
        label(l1)
        getlocal_OP__WC__0 local(:data)
        getlocal_OP__WC__0 local(:ptr)
        opt_aref callinfo(:[], 1, ARGS_SIMPLE), 0
        putobject_OP_INT2FIX_O_0_C_
        opt_eq callinfo(:==, 1, ARGS_SIMPLE), 0
        branchunless  l2
      end
    end

    def to_bin
      @builder.to_bin
    end

    def to_iseq
      @builder.to_iseq
    end
  end
end
