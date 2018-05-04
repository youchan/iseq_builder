require "iseq_builder"

iseq = ISeqBuilder.build do |builder|
  builder.top_level do |seq|
    seq << builder.insn(:putself)
    seq << builder.insn(:putstring, seq.string("Hello world"))
    seq << builder.insn(:opt_send_without_block, seq.call_info(:puts, ISeqBuilder::FCALL | ISeqBuilder::ARGS_SIMPLE, 1), 0)
    seq << builder.insn(:leave)
  end
end

iseq.eval
