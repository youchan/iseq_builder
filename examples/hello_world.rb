require "iseq_builder"

iseq = ISeqBuilder.build do |builder|
  builder.top_level do |seq|
    seq << seq.insn(:putself)
    seq << seq.insn(:putstring, seq.string("Hello world"))
    seq << seq.insn(:opt_send_without_block, seq.callinfo(:puts, ISeqBuilder::RUBY_ID_STATIC_SYM, 1, ISeqBuilder::FCALL | ISeqBuilder::ARGS_SIMPLE), 0)
    seq << seq.insn(:leave)
  end
end

iseq.eval
