require "iseq_builder"

iseq = ISeqBuilder.build do |builder|
  builder.top_level do
    putself
    putstring string("Hello world")
    opt_send_without_block callinfo(:puts, ISeqBuilder::RUBY_ID_STATIC_SYM, 1, ISeqBuilder::FCALL | ISeqBuilder::ARGS_SIMPLE), 0
    leave
  end
end

iseq.eval
