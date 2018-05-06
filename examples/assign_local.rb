require "iseq_builder"

iseq = ISeqBuilder.build do |builder|
  builder.top_level do
    putstring string("Hello world")
    setlocal_OP__WC__0 local(:hello)
    putself
    getlocal_OP__WC__0 local(:hello)
    opt_send_without_block callinfo(:puts, ISeqBuilder::RUBY_ID_INSTANCE, 1, ISeqBuilder::FCALL | ISeqBuilder::ARGS_SIMPLE), 0
    leave
  end
end

iseq.eval
