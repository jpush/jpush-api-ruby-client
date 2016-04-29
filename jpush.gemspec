# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jpush/version'

Gem::Specification.new do |spec|
  spec.name          = "jpush"
  spec.version       = JPush::VERSION
  spec.authors       = ["JPush Offical"]
  spec.email         = ["support@jpush.cn"]

  spec.summary       = %q{JPush's officially supported Ruby client library for accessing JPush APIs.}
  spec.description   = %q{JPush's officially supported Ruby client library for accessing JPush APIs. 极光推送官方支持的 Ruby 版本服务器端 SDK. 相应的 API 文档：http://docs.jpush.io/server/server_overview/ }
  spec.homepage      = "https://github.com/jpush/jpush-api-ruby-client"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.required_ruby_version = '>= 2.2'
end
