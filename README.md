# redis-rb-global-config 🌟

[![Gem Version](https://badge.fury.io/rb/redis-rb-global-config.svg)](https://badge.fury.io/rb/redis-rb-global-config)

Simplify your Redis configuration management across your Ruby applications! 🚀

## 🎯 Purpose

RedisRbGlobalConfig allows you to set default configurations for Redis connections across your Ruby application. This is particularly useful when you're using Redis for multiple purposes in a Rails application, such as:

- 🚂 Rails sessions
- 🗄️ Caching on a separate database
- 🧵 Sidekiq for background jobs
- 📡 ActionCable/AnyCable for real-time features

It also makes it easy to ensure all Redis connections use the high-performance Hiredis driver for improved speed! 💨

## 🛠️ Installation

Add this line to your application's Gemfile:

```ruby
gem 'redis-rb-global-config'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install redis-rb-global-config
```

## 🚀 Usage

Here's how you can use RedisRbGlobalConfig in your application:

```ruby
require 'redis-rb-global-config'

# Set global configuration
Redis.default_configuration = {
  host: ENV['REDIS_HOST'] || 'localhost',
  port: ENV['REDIS_PORT'] || 6379,
  db: 0,
  driver: :hiredis  # Use the high-performance Hiredis driver
}

# Create Redis instances with specific configurations
redis_cache = Redis.new(db: 1)
redis_sessions = Redis.new(db: 2)
redis_sidekiq = Redis.new(db: 3)

# The global configuration is merged with the specific options
```

### 🔧 Rails Configuration Example

In your `config/initializers/redis.rb`:

```ruby
require 'redis-rb-global-config'

Redis.default_configuration = {
  host: ENV['REDIS_HOST'] || 'localhost',
  port: ENV['REDIS_PORT'] || 6379,
  driver: :hiredis
}

# Cache Store
Rails.application.config.cache_store = :redis_cache_store, { db: 1 }

# Action Cable
Rails.application.config.action_cable.backend = :redis
Rails.application.config.action_cable.url = "redis://localhost:6379/2"

# Sessions
Rails.application.config.session_store :redis_store, 
  servers: [{ db: 3 }],
  expire_after: 90.minutes

# Sidekiq
Sidekiq.configure_server do |config|
  config.redis = { db: 4 }
end

Sidekiq.configure_client do |config|
  config.redis = { db: 4 }
end
```

This setup ensures that all Redis connections use the same host and port, and all benefit from the Hiredis driver, while still allowing you to use different databases for different purposes.

## 🧪 Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## 🤝 Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sebyx07/redis-rb-global-config. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](CODE_OF_CONDUCT.md).

## 📜 License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 🌈 Code of Conduct

Everyone interacting in the RedisRbGlobalConfig project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](CODE_OF_CONDUCT.md).