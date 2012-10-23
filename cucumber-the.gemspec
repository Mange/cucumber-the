# Encoding: utf-8
require File.expand_path('../lib/cucumber-the/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Magnus Bergmark"]
  gem.email         = ["magnus.bergmark@gmail.com"]
  gem.description   = %q{Adds quick access to instances to help you write more fluid steps.}
  gem.summary       = %q{Adds quick access to instances to help you write more fluid steps.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cucumber-the"
  gem.require_paths = ["lib"]
  gem.version       = Cucumber::The::VERSION
end
