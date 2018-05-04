module ISeqBuilder
  VM_CALL_ARGS_SPLAT_bit      = 0
  VM_CALL_ARGS_BLOCKARG_bit   = 1
  VM_CALL_ARGS_BLOCKARG_BLOCKPARAM_bit = 2
  VM_CALL_FCALL_bit           = 3
  VM_CALL_VCALL_bit           = 4
  VM_CALL_ARGS_SIMPLE_bit     = 5
  VM_CALL_BLOCKISEQ_bit       = 6
  VM_CALL_KWARG_bit           = 7
  VM_CALL_KW_SPLAT_bit        = 8
  VM_CALL_TAILCALL_bit        = 9
  VM_CALL_SUPER_bit           = 10
  VM_CALL_OPT_SEND_bit        = 11

  ARGS_SPLAT      = (0x01 << VM_CALL_ARGS_SPLAT_bit)
  ARGS_BLOCKARG   = (0x01 << VM_CALL_ARGS_BLOCKARG_bit)
  ARGS_BLOCKARG_BLOCKPARAM = (0x01 << VM_CALL_ARGS_BLOCKARG_BLOCKPARAM_bit)
  FCALL           = (0x01 << VM_CALL_FCALL_bit)
  VCALL           = (0x01 << VM_CALL_VCALL_bit)
  ARGS_SIMPLE     = (0x01 << VM_CALL_ARGS_SIMPLE_bit)
  BLOCKISEQ       = (0x01 << VM_CALL_BLOCKISEQ_bit)
  KWARG           = (0x01 << VM_CALL_KWARG_bit)
  KW_SPLAT        = (0x01 << VM_CALL_KW_SPLAT_bit)
  TAILCALL        = (0x01 << VM_CALL_TAILCALL_bit)
  SUPER           = (0x01 << VM_CALL_SUPER_bit)
  OPT_SEND        = (0x01 << VM_CALL_OPT_SEND_bit)
end
