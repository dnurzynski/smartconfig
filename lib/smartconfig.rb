require_relative 'smartconfig/proxy'
require_relative 'smartconfig/setting'
require_relative 'smartconfig/adapters/yaml'

class SmartConfig
  KeyExists = Class.new(StandardError)

  def self.new!(*adapters, &block)
    config = new(*adapters, &block)
    config.load
    config
  end

  def initialize(*adapters)
    @settings = {}
    @adapters = adapters.map do |adapter|
      case adapter
      when /\.yml$/, /\.yaml$/
        Adapters::Yaml.new adapter
      else
        adapter
      end
    end

    yield Proxy.new(self) if block_given?
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
