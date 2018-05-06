require "iseq_builder"

iseq = ISeqBuilder.build do |builder|
  builder.top_level() do |seq|
    seq << seq.insn(:putstring, seq.string("Hello world"))
    seq << seq.insn(:setlocal_OP__WC__0, seq.local(:hello))
    seq << seq.insn(:putself)
    seq << seq.insn(:getlocal_OP__WC__0, seq.local(:hello))
    seq << seq.insn(:opt_send_without_block, seq.callinfo(:puts, ISeqBuilder::RUBY_ID_INSTANCE, 1, ISeqBuilder::FCALL | ISeqBuilder::ARGS_SIMPLE), 0)
    seq << seq.insn(:leave)
  end
end

iseq.eval
