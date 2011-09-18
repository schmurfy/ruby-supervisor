# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby-supervisor/version"

Gem::Specification.new do |s|
  s.name        = "ruby-supervisor"
  s.version     = RubySupervisor::VERSION
  s.authors     = ["Julien Ammous"]
  s.email       = ["schmurfy@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Ruby Interface to supervisord}
  s.description = %q{uses XMLRPC supervisord API to communciate with supervisord}

  s.rubyforge_project = "ruby-supervisor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # s.add_runtime_dependency "rest-client"
  
  s.add_development_dependency "rspec",       '~> 2.6'
  s.add_development_dependency "guard",       '~> 0.7.0'
  s.add_development_dependency "guard-rspec", '~> 0.4.5'
  s.add_development_dependency "growl",       '~> 1.0.3'
  s.add_development_dependency "rb-fsevent",  '~> 0.4.3'
  s.add_development_dependency "mocha",       '~> 0.10.0'
  s.add_development_dependency "simplecov",   '~> 0.5.3'
  s.add_development_dependency "rake",        '~> 0.9.2'
end
