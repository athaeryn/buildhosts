# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildhosts/version'

Gem::Specification.new do |spec|
  spec.name          = "buildhosts"
  spec.version       = Buildhosts::VERSION
  spec.authors       = ["Mike Anderson"]
  spec.email         = ["athaeryn@me.com"]
  spec.description   = "Buildhosts."
  spec.summary       = "A utiliy for managing hosts (and IPs for xip.io)."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
