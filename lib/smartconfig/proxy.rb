class SmartConfig
  class Proxy
    def initialize(config_instance)
      @config_instance = config_instance
    end

    def key(*opts)
      @config_instance.add_key(*opts)
    end
  end
end
