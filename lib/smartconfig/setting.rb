class SmartConfig
  class Setting
    def initialize(options)
      @default = options[:default]
    end

    def set(other)
      @value = other
    end

    def get
      @value || @default
    end
  end
end
