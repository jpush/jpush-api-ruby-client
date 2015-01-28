# coding: utf-8
require 'rubygems'
require 'rake'
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
PKG_FILES = FileList[
'lib/*.rb',
'lib/jpush/*.rb',
'lib/jpush/**/*.rb',
'lib/jpush/model/notification/*.rb'
]
Gem::Specification.new do |spec|
  spec.name          = "jpush"
  spec.version       = "3.2.1"
  spec.authors       = ['JPush Offical']
  spec.email         = ['support@jpush.cn']
  spec.description   = "JPush's officially supported Ruby client library for accessing JPush APIs. http://jpush.cn"
  spec.summary       = "JPush's officially supported Ruby client library for accessing JPush APIs."
  spec.homepage      = "https://github.com/jpush/jpush-api-ruby-client"
  spec.license       = "GNU"

  spec.files         = PKG_FILES 
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 2.6"
  #spec.add_runtime_dependency "rest-client","~> 1.6.7"
  #spec.add_runtime_dependency "json", "~> 1.7.7"

end
