# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch-storage/version'

Gem::Specification.new do |gem|
  gem.name          = "cinch-storage"
  gem.version       = Cinch::Storage::VERSION
  gem.authors       = ["Brian Haberer"]
  gem.email         = ["bhaberer@gmail.com"]
  gem.description   = %q{Simle YAML backed Storage solution for Cinch plugins.}
  gem.summary       = %q{Simle YAML backed Storage solution for Cinch plugins.}
  gem.homepage      = "https://github.com/bhaberer/cinch-storage"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('psych', '1.3.4')
end