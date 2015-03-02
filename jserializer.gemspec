# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jserializer/version'

Gem::Specification.new do |spec|
  spec.name          = "jserializer"
  spec.version       = JSerializer::VERSION
  spec.authors       = ["Andrius Chamentauskas"]
  spec.email         = ["andrius.chamentauskas@gmail.com"]
  spec.summary       = %q{Gem for serializing ActiveRecord objects to json as fast and flexible as possible}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "database_cleaner", "~> 1.3.0" # 1.4.0 has a bug that drops migrations
  spec.add_development_dependency "blueprints_boy"
  spec.add_development_dependency "pg"
  spec.add_dependency "oj"
  spec.add_dependency "activerecord"
end
