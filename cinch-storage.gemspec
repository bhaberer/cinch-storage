# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cinch/storage/version'

Gem::Specification.new do |gem|
  gem.name          = 'cinch-storage'
  gem.version       = Cinch::Storage::VERSION
  gem.authors       = ['Brian Haberer']
  gem.email         = ['bhaberer@gmail.com']
  gem.description   = %q(Simple YAML backed Storage for Cinch plugins.)
  gem.summary       = %q(Data Storage for Cinch plugins.)
  gem.homepage      = 'https://github.com/bhaberer/cinch-storage'
  gem.license       = 'MIT'
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(/^bin\//).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^(test|spec|features)\//)
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'cinch-test', '~> 0.0', '>= 0.0.2'

  gem.add_dependency 'cinch', '~> 2', '>= 2.0.8'
  gem.add_dependency 'psych', '~> 2.0', '>= 2.0.4'
end
