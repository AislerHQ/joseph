# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'joseph/version'

Gem::Specification.new do |spec|
  spec.name          = "joseph"
  spec.version       = Joseph::VERSION
  spec.authors       = ["Patrick Franken", "AISLER B.V."]
  spec.email         = ["p.franken@aisler.net"]
  spec.summary       = "Make working with gerber files great again"
  spec.description   = "Read, modify and writer Gerber RS274X files with ruby using libgerbv bindings and some sugar."
  spec.homepage      = "http://aisler.net"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'ffi', '~> 1.9'
  spec.add_runtime_dependency 'ramdo', '~> 0.2'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "geminabox"
  spec.add_development_dependency "chunky_png"
end
