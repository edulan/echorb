# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "echorb/version"

Gem::Specification.new do |s|
  s.name        = "echorb"
  s.version     = Echorb::VERSION
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "echorb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "cucumber", "1.1.9"
  s.add_development_dependency "rspec", "2.7.0"
  s.add_development_dependency "webmock", "1.8.0"
end
