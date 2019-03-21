# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proxmox/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-proxmox'
  spec.version       = Proxmox::VERSION
  spec.authors       = ['Nathaniel Suchy', 'Nicolas Ledez']
  spec.email         = ['me@lunorian.is']
  spec.description   = 'A ruby gem for managing Proxmox Servers with Ruby. Based on https://github.com/nledez/proxmox'
  spec.summary       = 'A ruby gem for managing Proxmox Servers with Ruby. Based on https://github.com/nledez/proxmox'
  spec.homepage      = 'https://github.com/ulayer/ruby-proxmox'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.add_dependency 'rest-client', '>=1.6.7'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
end
