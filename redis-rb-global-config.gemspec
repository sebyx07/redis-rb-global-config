# frozen_string_literal: true

require_relative 'lib/redis-rb-global-config/version'

Gem::Specification.new do |spec|
  spec.name = 'redis-rb-global-config'
  spec.version = RedisRbGlobalConfig::VERSION
  spec.authors = ['sebi']
  spec.email = ['gore.sebyx@yahoo.com']

  spec.summary = 'A gem to provide global configuration for the redis-rb gem'
  spec.description = 'RedisRbGlobalConfig allows you to set default configurations for Redis connections across your Ruby application.'
  spec.homepage = 'https://github.com/sebyx07/redis-rb-global-config'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/sebyx07/redis-rb-global-config'
  spec.metadata['changelog_uri'] = 'https://github.com/sebyx07/redis-rb-global-config/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'redis', '>= 5.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
