
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "iseq_builder/version"

Gem::Specification.new do |spec|
  spec.name          = "iseq_builder"
  spec.version       = ISeqBuilder::VERSION
  spec.authors       = ["youchan"]
  spec.email         = ["youchan01@gmail.com"]

  spec.summary       = %q{iSeq builder}
  spec.description   = %q{Building iSeq programmably.}
  spec.homepage      = "https://github.com/youchan/iseq_builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
