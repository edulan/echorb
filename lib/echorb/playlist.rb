require "echorb/base"
require "echorb/song"

module Echorb
  class Playlist < Echorb::Base
    def songs
      @songs || @attrs[:songs].collect { |song| Echorb::Song.new(song) }
    end
  end
end