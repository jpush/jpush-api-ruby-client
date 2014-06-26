# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jpush/version"

Gem::Specification.new do |spec|
  spec.name          = "jpush"
  spec.version       = JPush::VERSION
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

  spec.add_dependency 'rest-client', "~> 1.6.7"
  spec.add_dependency "json", "> 1.7.7"

end
