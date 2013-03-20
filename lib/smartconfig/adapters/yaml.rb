require 'yaml'

class SmartConfig
  module Adapters
    class Yaml
      def initialize(filename)
        @filename = filename
      end

      def data
        @data ||= YAML.load_file @filename
      end

      def each
        data.each do |key, value|
          yield key.to_sym, value
        end
      end
    end
  end
end
