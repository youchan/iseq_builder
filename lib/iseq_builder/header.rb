module ISeqBuilder
  class Header
    MAGIC = "YARB"

    def initialize(major = 2, minor = 5, platform = RUBY_PLATFORM)
      @major = major
      @minor = minor
      @platform = platform

      @iseq_list = []
      @iseq_list_offset = 0
      @id_list = []
      @id_list_offset = 0
      @object_list = []
      @object_list_offset = 0
    end

    def iseq_list(list, offset)
      @iseq_list = list
      @iseq_list_offset = offset
    end

    def id_list(list, offset)
      @id_list = list
      @id_list_offset = offset
    end

    def object_list(list, offset)
      @object_list = list
      @object_list_offset = offset
    end

    def size
      @object_list_offset + @object_list.size * 4
    end

    def extra_size
      0
    end

    def to_bin
      [
        MAGIC,
        @major,
        @minor,
        size,
        extra_size,
        @iseq_list.size,
        @id_list.size,
        @object_list.size, 
        @iseq_list_offset,
        @id_list_offset,
        @object_list_offset,
        @platform
      ].pack("a4I10Z*")
    end

    def override(bin)
      bin[12, 4 * 8] = [
        size, 
        extra_size,
        @iseq_list.size,
        @id_list.size,
        @object_list.size, 
        @iseq_list_offset,
        @id_list_offset,
        @object_list_offset].pack("I*")
    end

    def inspect
<<STR
== #{MAGIC} #{@major}.#{@minor} ============
size: #{size} (extra = #{extra_size})
iseq_list: size: #{@iseq_list.size}, offset: #{@iseq_list_offset}
id_list: size: #{@id_list.size}, offset: #{@id_list_offset}
object_list: size: #{@object_list.size}, offset: #{@object_list_offset}
STR
    end
  end
end
