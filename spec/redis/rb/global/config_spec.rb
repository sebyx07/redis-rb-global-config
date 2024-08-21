# frozen_string_literal: true

RSpec.describe RedisRbGlobalConfig do
  let(:default_config) do
    {
      host: 'localhost',
      port: 6379,
      db: 0,
      timeout: 5
    }
  end

  before do
    Redis.default_configuration = nil
  end

  it 'has a version number' do
    expect(RedisRbGlobalConfig::VERSION).not_to be nil
  end

  describe '.default_configuration' do
    it 'allows setting a default configuration' do
      Redis.default_configuration = default_config
      expect(Redis.default_configuration).to eq(default_config)
    end
  end

  describe '#initialize' do
    before do
      Redis.default_configuration = default_config
    end

    it 'uses the default configuration when no options are provided' do
      redis = Redis.new
      expect(redis.instance_variable_get(:@options)).to include(default_config)
    end

    it 'merges provided options with default configuration' do
      custom_options = { port: 6380, password: 'secret' }
      redis = Redis.new(custom_options)
      expected_options = default_config.merge(custom_options)
      expect(redis.instance_variable_get(:@options)).to include(expected_options)
    end

    it 'overrides default configuration with provided options' do
      custom_options = { host: '127.0.0.1', port: 6380 }
      redis = Redis.new(custom_options)
      expect(redis.instance_variable_get(:@options)).to include(custom_options)
      expect(redis.instance_variable_get(:@options)[:host]).to eq('127.0.0.1')
      expect(redis.instance_variable_get(:@options)[:port]).to eq(6380)
    end
  end

  describe 'deep merging' do
    it 'correctly deep merges nested configurations' do
      Redis.default_configuration = {
        host: 'localhost',
        port: 6379,
        ssl: { verify: true, ca_file: '/path/to/ca.crt' }
      }
      custom_options = {
        port: 6380,
        ssl: { verify: false }
      }
      redis = Redis.new(custom_options)
      expect(redis.instance_variable_get(:@options)).to include(
                                                          host: 'localhost',
                                                          port: 6380,
                                                          ssl: { verify: false, ca_file: '/path/to/ca.crt' }
                                                        )
    end
  end

  describe 'without default configuration' do
    it 'uses provided options when no default configuration is set' do
      custom_options = { host: '127.0.0.1', port: 6380 }
      redis = Redis.new(custom_options)
      expect(redis.instance_variable_get(:@options)).to include(custom_options)
    end
  end
end
