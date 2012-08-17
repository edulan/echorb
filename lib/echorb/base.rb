require "json"

module Echorb
  class Base
    attr_reader :attrs

    def self.attr_reader(*attrs)
      attrs.each do |attribute|
        class_eval do
          define_method attribute do
            @attrs[attribute.to_sym]
          end
        end
      end
    end

    def self.from_response response
      attrs = self.parse_response(response)
      self.new(attrs)
    end

    def initialize(attrs={})
      self.update(attrs)
    end

    def update attrs
      @attrs ||= {}
      @attrs.update(attrs)
      self
    end

    def id
      @attrs[:id]
    end

    def to_json(*a)
      @attrs.to_json(*a)
    end

    def self.parse_response response
      response && response.reject { |k, v| k == :status }
    end
  end
end