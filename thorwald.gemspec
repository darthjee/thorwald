# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thorwald/version'

Gem::Specification.new do |gem|
  gem.name          = 'thorwald'
  gem.version       = Thorwald::VERSION
  gem.authors       = ["Darthjee"]
  gem.email         = ["darthjee@gmail.com"]
  gem.homepage      = 'https://github.com/darthjee/thorwald'
  gem.description   = 'Gem for quick data exposure'
  gem.summary       = gem.description

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f)  }
  gem.test_files    = gem.files.grep(%r{^(test|gem|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec"
end
