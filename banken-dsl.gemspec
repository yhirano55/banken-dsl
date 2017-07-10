$:.push File.expand_path("../lib", __FILE__)
require "banken/dsl/version"

Gem::Specification.new do |s|
  s.name        = "banken-dsl"
  s.version     = Banken::DSL::VERSION
  s.authors     = ["Yoshiyuki Hirano"]
  s.email       = ["yhirano@me.com"]
  s.summary     = %q{DSL for Banken}
  s.description = %q{This plugin gives directly define query methods to the controller for a Banken loyalty class by DSL}
  s.homepage    = "https://github.com/yhirano55/banken-dsl"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.0"

  s.add_dependency "banken", ">= 1.0.2"

  s.add_development_dependency "bundler", "~> 1.15"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.require_paths = ["lib"]
end
