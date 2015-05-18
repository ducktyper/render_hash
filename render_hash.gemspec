# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'render_hash/version'

Gem::Specification.new do |spec|
  spec.name          = "render_hash"
  spec.version       = RenderHash::VERSION
  spec.authors       = ["Ducksan Cho"]
  spec.email         = ["ducktyper@gmail.com"]
  spec.summary       = %q{Build a hash from an object}
  spec.description   = %q{render_hash is an alternative to .as_json in rails providing simple syntax to generate nested hash from any ruby object}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
