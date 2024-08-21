# frozen_string_literal: true

require 'redis'
require_relative './redis-rb-global-config/version'

module RedisRbGlobalConfig
  def self.prepended(base)
    class << base
      attr_accessor :default_configuration
    end
  end

  def initialize(options = {})
    options = __configure_options(options)
    super(options)
  end

  private
    def __configure_options(options)
      default_configuration = self.class.default_configuration
      return options unless default_configuration

      h_deep_merge(default_configuration, options)
    end

    def h_deep_merge(hash1, hash2)
      result = hash1.dup
      hash2.each do |key, value|
        result[key] = if value.is_a?(Hash) && result[key].is_a?(Hash)
          h_deep_merge(result[key], value)
        else
          value
        end
      end
      result
    end
end

Redis.prepend(RedisRbGlobalConfig)
