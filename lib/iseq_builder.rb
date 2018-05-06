require "iseq_builder/version"

require "iseq_builder/vm_constants"
require "iseq_builder/vm_call"
require "iseq_builder/ruby_id"
require "iseq_builder/ruby_event"
require "iseq_builder/iseq_object"
require "iseq_builder/call_info"
require "iseq_builder/insn_type"
require "iseq_builder/insns_info"
require "iseq_builder/insn"
require "iseq_builder/iseq_constant_body"
require "iseq_builder/header"
require "iseq_builder/location"
require "iseq_builder/sequence"
require "iseq_builder/builder"

module ISeqBuilder
  def self.builder
    Builder.new
  end

  def self.build(&block)
    block.call(builder = Builder.new)
    builder.to_iseq
  end
end
