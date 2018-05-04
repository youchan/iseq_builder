module ISeqBuilder
  class Location
    def initialize
      @pathobj = 1
      @base_label = 2
      @label = 2
      @first_lineno = 0

      @first_code_location = CodeLocation.new(0, 0)
      @last_code_location = CodeLocation.new(0, 0)
    end

    def to_bin
      bin = ""
      bin << [ @pathobj, @base_label, @label, @first_lineno ].pack("q4")
      bin << @first_code_location.to_bin
      bin << @last_code_location.to_bin
    end

    def inspect
      "pathobj: #{@pathobj}, base_label: #{@base_label}, label: #{@label}, first_lineno: #{@first_lineno}, first: [#{@first_code_location}], last: [#{@last_code_location}]"
    end

    class CodeLocation
      attr_reader :lineno, :column

      def initialize(lineno, column)
        @lineno = lineno
        @column = column
      end

      def to_bin
        [@lineno, @column].pack("I2")
      end

      def inspect
        "lineno: #{@lineno}, column: #{@column}"
      end
    end
  end
end
