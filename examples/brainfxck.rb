#############################
# brainf*ck.rb
#
# A brainf*ck compiler compiling to ISeq
#
# Usage.
#   compiling brainf*ck source code to ISeq binary
#   $ bundle exec ruby brainfxck.rb -c -o helloworld.bin bf/helloworld.bf
#
#   executing ISeq binary
#   $ bundle exec ruby brainfxck.rb -e helloworld.bin

require "optparse"
require_relative "./bf/iseq_compiler"

opts = ARGV.getopts("ceo:s")

compiler = BF::ISeqCompiler.new

if opts["c"] || opts["s"]
  program = open(ARGV[0]).read.split(?\n).join

  m = program.chars.each_with_object({prev:nil,count:0}) do |c, m|
    if "><+-".chars.include?(c) && c == m[:prev]
      m[:count] += 1
      next
    end

    compiler.compile_char_opt(m[:prev], m[:count])
    compiler.compile_char(c)

    m[:prev] = c
    m[:count] = 1
  end

  compiler.compile_char_opt(m[:prev], m[:count])
  compiler.leave

  out = opts["o"] ? File.open(opts["o"], "w") : $stdout

  if opts["s"]
    out.write(compiler.to_iseq.diasm)
    return
  end

  out.write compiler.to_bin
elsif opts["e"]
  if ARGV[0]
    bin = File.read(ARGV[0])
  else
    bin = $stdin.read
  end

  iseq = RubyVM::InstructionSequence.load_from_binary(bin)
  iseq.eval
end
