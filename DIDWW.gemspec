# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'DIDWW/version'

Gem::Specification.new do |spec|
  spec.name          = "DIDWW"
  spec.version       = DIDWW::VERSION
  spec.authors       = ["Julien Chabanon"]
  spec.email         = ["julien.chabanon@modulis.ca"]
  spec.summary       = %q{A simple API wrapper for DIDWW SOAP API}
  spec.description   = %q{This API wrapper is meant to provide a rails friendly configurable api wrapper to access DIDWW's SOAP based API using Savon gem.}
  spec.homepage      = "http://github.com/modulis/DIDWW-API-WRAPPER"
  spec.license       = "MIT"

  spec.name          = "didww-client"
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.require_paths = ["lib"]
  spec.version       = DIDWW::VERSION

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "savon", "~> 2.11.1"
end
