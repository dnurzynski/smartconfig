require_relative 'smartconfig/proxy'
require_relative 'smartconfig/setting'

class SmartConfig
  KeyExists = Class.new(StandardError)

  def self.new! options = {}
    new(options).tap do |config|
      config.load
      config.freeze
    end
  end

  def initialize options = {}
    @settings = {}

    @adapters = if options[:adapter]
                  [options[:adapter]]
                else
                  options[:adapters]
                end

    yield Proxy.new self if block_given?
  end

  def load
    @adapters.each do |adapter|
      adapter.each do |key, value|
        @settings[key].set(value)
      end
    end
  end

  def add_key(key_name, options = {})
    raise KeyExists.new("Key '#{key_name}' was already defined") if @settings[key_name]
    @settings[key_name] = Setting.new options

    metaclass = class<<self; self; end
    metaclass.send :define_method, key_name do
      @settings[key_name].get
    end
  end
end
