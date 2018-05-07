require "iseq_builder"

include ISeqBuilder

iseq = ISeqBuilder.build do |builder|
  builder.top_level do
    getinlinecache 4, 0
    getconstant      constant(:Array)
    setinlinecache 0
    putobject        integer(10)
    opt_send_without_block callinfo(:new, 1, ARGS_SIMPLE), 0
    setlocal_OP__WC__0 local(:array)
    putself
    getlocal_OP__WC__0  local(:array)
    opt_send_without_block callinfo(:p, 1, FCALL | ARGS_SIMPLE), 0
    leave
  end
end

iseq.eval
