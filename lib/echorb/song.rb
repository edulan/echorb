require "echorb/base"

module Echorb
  class Song < Echorb::Base
    attr_reader :title, :artist_name, :artist_id, :audio_summary, :artist_familiarity,
                :artist_hotttnesss, :artist_location, :song_hotttnesss

    def tracks
      []
    end
  end
end