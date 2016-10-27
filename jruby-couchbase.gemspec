Gem::Specification.new do |gem|

  gem.name = "jruby-couchbase"
  gem.version = "1.0.2"
  gem.authors = ["ZUP"]
  gem.email = ["rodrigo.saramago@zup.com.br"]
  gem.description = %q{JRuby wrapper to Couchbase Java SDK}
  gem.summary = %q{A jruby wrapper of the Couchbase Java SDK.}
  gem.license = "Apache-2.0"
  gem.require_paths = ["lib"]
  gem.platform = "java"

  # Files
  gem.files = Dir['lib/**/*','spec/**/*', 'vendor/**/*', '*.gemspec','*.md','Gemfile']

  # Tests
  gem.test_files = gem.files.grep(%r{^(test|spec|features)/})

  # Gem dependencies
  gem.requirements << "jar 'com.couchbase.client:java-client', '2.3.1'"

  gem.add_runtime_dependency 'multi_json', '~> 1.12', '>= 1.12.1'

  gem.add_development_dependency "jar-dependencies", '~> 0.3.2'
  gem.add_development_dependency 'ruby-maven', '~> 3.3', '>= 3.3.11'
  gem.add_development_dependency 'rake', '~> 11.3'
  gem.add_development_dependency 'rspec', '~> 3.5'

end
