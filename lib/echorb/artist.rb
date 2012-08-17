require "echorb/base"

module Echorb
  class Artist < Echorb::Base
    attr_reader :name, :familiarity, :hotttnesss, :terms, :years_active

    def songs
      @songs ||= @attrs[:songs].collect { |song| Song.from_response(song) }
    end
  end
end