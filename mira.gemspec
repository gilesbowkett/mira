# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mira/version"

Gem::Specification.new do |s|
  s.name        = "mira"
  s.version     = Mira::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Giles Bowkett"]
  s.email       = ["gilesb@gmail.com"]
  s.homepage    = ""
  s.summary     =  s.description = %q{Bare minimum Viddler API v2}

  s.rubyforge_project = "mira"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specs
  s.add_development_dependency 'rake', '0.8.7'
  s.add_development_dependency 'rspec'

  # I don't understand how people can tolerate IRB without my improvements to it. I
  # get that this is arrogant, but it's also absolutely sincere.
  s.add_development_dependency 'utility_belt'

  # api methods
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'rest-client'

  # ordered hash
  s.add_runtime_dependency 'activesupport'
end

