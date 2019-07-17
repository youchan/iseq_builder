module ISeqBuilder
  class Builder
    attr_reader :sequences, :id_list, :objects

    def initialize(objpath = "", label = "<compiled>")
      @sequences = []
      @sequences << Sequence.new(self)
      @id_list = []
      @objects = []
      self.identifiable_object(ISeqBuilder::T_NIL, true, true, true)
      self.object(T_STRING, false, true, false, objpath)
      self.object(T_STRING, false, true, false, label)
    end

    def top_level(&block)
      top_level = sequences.first

      if block
        top_level.instance_eval &block
      end

      top_level
    end

    def new_sequence(type)
      @sequences << (seq = Sequence.new(self, type))
      seq
    end

    def add_sequence(type, &block)
      block.call(seq = Sequence.new(self, type))
      @sequences << seq
      seq
    end

    def object(type, special_const, frozen, internal, value = nil)
      @objects << object = ISeqObject.new(type, @objects.length, special_const, frozen, internal, value)
      object
    end

    def identifiable_object(type, special_const, frozen, internal, value = nil)
      object = self.object(type, special_const, frozen, internal, value)
      idx = @id_list.length
      @id_list << object.id
      idx
    end

    def to_bin
      bin = ""
      header = Header.new
      bin << header.to_bin

      iseq_list = []
      @sequences.each do |sequence|
        constant_body = sequence.constant_body(bin.length)
        bin << sequence.to_bin
        iseq_list << bin.length
        bin << constant_body.to_bin
      end
      
      header.iseq_list(iseq_list, bin.length)
      bin << iseq_list.pack("I*")

      header.id_list(@id_list, bin.length)
      bin << @id_list.pack("Q*")

      object_list = []
      @objects.each do |object|
        object_list << bin.length
        bin << object.to_bin
      end

      header.object_list(object_list, bin.length)
      bin << object_list.pack("I*")

      header.override(bin)
      bin
    end

    def to_iseq
      RubyVM::InstructionSequence.load_from_binary(self.to_bin)
    end
  end
end
