module ISeqBuilder
  class ISeqObject
    attr_reader :type, :id, :special_const, :frozen, :internal

    def initialize(type, id, special_const, frozen, internal, object = nil)
      @type = type
      @id = id
      @object = object

      @header = type_num
      @header |= 0b00100000 if special_const
      @header |= 0b01000000 if frozen
      @header |= 0b10000000 if internal
      @header |= (0b01111111 << 8)
    end

    def body
      case @type
      when T_STRING
        [2, @object.size, @object]
      when T_NIL
        [8]
      end
    end

    def encode_string
      case @type
      when T_STRING
        "Q2a*"
      when T_NIL
        "Q"
      end
    end

    def type_num
      RUBY_T_MASK.index(@type)
    end

    def to_bin
      [@header, *body].pack("I#{encode_string}")
    end

    def to_s
      if @object
        @object.inspect
      elsif @type == T_NIL
        "nil"
      else
        "#{@type}: special_const: #{@special_const}, frozen: #{@frozen}, internal: #{@internal}"
      end
    end
  end

  RUBY_T_MASK = [
    T_NONE      = :none,
    T_OBJECT    = :object,
    T_CLASS     = :class,
    T_MODULE    = :module,
    T_FLOAT     = :float,
    T_STRING    = :string,
    T_REGEXP    = :regexp,
    T_ARRAY     = :array,
    T_HASH      = :hash,
    T_STRUCT    = :struct,
    T_BIGNUMi   = :bignum,
    T_FILE      = :file,
    T_DATA      = :data,
    T_MATCH     = :match,
    T_COMPLEX   = :complex,
    T_RATIONAL  = :rational,
    0x10,
    T_NIL       = :nil,
    T_TRUE      = :true,
    T_FALSE     = :false,
    T_FIXNUM    = :fixnum,
    T_UNDEF     = :undef,
    0x17,
    0x18,
    0x19,
    T_IMEMO     = :imemo,
    T_NODE      = :node,
    T_ICLASS    = :iclass,
    T_ZOMBIE    = :zombie,
    0x1e,
    0x1f,
  ]
end
