require "echorb/base"

module Echorb
  class Catalog < Echorb::Base
    attr_reader :name, :type, :total, :resolved, :ticket
  end
end