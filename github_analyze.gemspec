lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_analyze/version'

Gem::Specification.new do |spec|
  spec.name = 'github_analyze'
  spec.version = GithubAnalyze::VERSION
  spec.authors = ['George Drummond']
  spec.email = %w[georgedrummond@gmail.com]

  spec.summary = 'Analyze GitHub organizations for language data'
  spec.description = 'Analyze GitHub organizations for language data. Check documentation at https://github.com/georgedrummond/github_analyze'
  spec.homepage = 'https://github.com/georgedrummond/github_analyze'
  spec.licenses = ['MIT']

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files =
    Dir.chdir(File.expand_path('..', __FILE__)) do
      `git ls-files -z`.split("\x0").reject do |f|
        f.match(%r{^(test|spec|features)/})
      end
    end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 5.0'
  spec.add_development_dependency 'webmock', '~> 3.6'
  spec.add_development_dependency 'prettier', '~> 0.14'
  spec.add_development_dependency 'pry', '~> 0.12'

  spec.add_dependency 'graphlient', '~> 0.3'
  spec.add_dependency 'thor', '~> 0.20'
end
