module ISeqBuilder
  ISEQ_TYPE_TOP = :top_level
  ISEQ_TYPE_METHOD = :method
  ISEQ_TYPE_BLOCK = :block
  ISEQ_TYPE_CLASS = :class
  ISEQ_TYPE_RESCUE = :rescue
  ISEQ_TYPE_ENSURE = :ensure
  ISEQ_TYPE_EVAL = :eval
  ISEQ_TYPE_MAIN = :main
  ISEQ_TYPE_DEFINED_GUARD = :defined_guard

  SEQUENCE_TYPES = [
    ISEQ_TYPE_TOP,
    ISEQ_TYPE_METHOD,
    ISEQ_TYPE_BLOCK,
    ISEQ_TYPE_CLASS,
    ISEQ_TYPE_RESCUE,
    ISEQ_TYPE_ENSURE,
    ISEQ_TYPE_EVAL,
    ISEQ_TYPE_MAIN,
    ISEQ_TYPE_DEFINED_GUARD
  ]

  class ISeqConstantBody
    def initialize(sequence, type, offset)
      @type = type
      @iseq_size = sequence.insns.sum(&:size)
      @iseq_encoded = offset
      @params = Array.new(12, 0)
      @location = Location.new
      @insns_info_offset = @iseq_encoded + @iseq_size * 8
      @insns_info_size = sequence.insns_info.size
      @local_table_size = sequence.local_table.size
      @local_table_offset = @insns_info_offset + @insns_info_size * 12
      @catch_table = 0
      @parent_iseq = -1
      @local_iseq = 0
      @is_entries = 0
      @ci_entries_offset = @local_table_offset  + @local_table_size * 8
      @cc_entries = 0
      @mark_ary = 0
      @is_size = 0
      @ci_size = sequence.call_info.size
      @ci_kw_size = 0
      @stack_max = 2
    end

    def type_num
      SEQUENCE_TYPES.index(@type)
    end

    def to_bin
      [
        type_num,
        @iseq_size,
        @iseq_encoded,
        *@params
      ].pack("I2QI12") +
      @location.to_bin +
      [
        @insns_info_offset,
        @local_table_offset,
        @catch_table,
        @parent_iseq,
        @local_iseq,
        @is_entries,
        @ci_entries_offset,
        @cc_entries,
        @mark_ary,
        @local_table_size,
        @is_size,
        @ci_size,
        @ci_kw_size,
        @insns_info_size,
        @stack_max,
      ].pack("q9I6")
    end
  end
end
