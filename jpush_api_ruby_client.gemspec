# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jpush_api_ruby_client/version"

Gem::Specification.new do |spec|
  spec.name          = "jpush_api_ruby_client"
  spec.version       = JPushApiRubyClient::VERSION
  spec.authors       = ['Xian OuYang']
  spec.email         = ['ouyangxian@gmail.com']
  spec.description   = "provide a ruby api gem for jpush https://www.jpush.cn"
  spec.summary       = "a ruby api client gem for jpush"
  spec.homepage      = "https://github.com/jpush/jpush-api-ruby-client"
  spec.license       = "GNU"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_runtime_dependency "rest-client","~> 1.6.7"
  spec.add_runtime_dependency "json", "~> 1.8"

end
