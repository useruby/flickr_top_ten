# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flickr_top_ten/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexey Artamonov"]
  gem.email         = ["i@useruby.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "flickr_top_ten"
  gem.require_paths = ["lib"]
  gem.version       = FlickrTopTen::VERSION

  gem.add_runtime_dependency('flickraw')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('debugger')
  gem.add_development_dependency('timecop')
end
