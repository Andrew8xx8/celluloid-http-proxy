# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'celluloid-http-proxy/version'

Gem::Specification.new do |gem|
  gem.name          = "celluloid-http-proxy"
  gem.version       = Celluloid::Http::Proxy::VERSION
  gem.authors       = ["Andrew8xx8", "Rozhnov Alexandr"]
  gem.email         = ["avk@8xx8.ru", "nox73@ya.ru"]
  gem.description   = "Celluloid::IO-powered http web proxy"
  gem.summary       = "Celluloid::IO-powered http web proxy"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('simple_pid')
  gem.add_runtime_dependency('reel')
  gem.add_runtime_dependency('virtus')
  gem.add_runtime_dependency('multi_json')
  gem.add_runtime_dependency('simple_router')
  gem.add_runtime_dependency('activesupport')
  gem.add_runtime_dependency('celluloid-http', '~> 0.0.6')

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
