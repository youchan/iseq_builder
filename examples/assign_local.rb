require "iseq_builder"

include ISeqBuilder

iseq = ISeqBuilder.build do |builder|
  builder.top_level do
    putstring string("Hello world")
    setlocal_OP__WC__0 local(:hello)
    putself
    getlocal_OP__WC__0 local(:hello)
    opt_send_without_block callinfo(:puts, 1, FCALL | ARGS_SIMPLE), 0
    leave
  end
end

iseq.eval
