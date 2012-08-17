require "spec_helper"

module Echorb
  describe Client do
    before do
      @api_key = "N6E4NIOVYMTHNDM8J"
      @client = Client.new(@api_key)
    end

    describe "#playlist_create" do
      before do
        stub_get("/playlist/static").
            with(:query => {:artist => "Radiohead", :type => :artist, :api_key => @api_key}).
            to_return(:status => 200, :body => fixture("playlist/static.json"),
              :headers => {:content_type => "application/json; charset=utf-8"})       
      end

      it "requests the correct resource" do
        @client.playlist_create(:artist => "Radiohead", :type => :artist)

        a_get("/playlist/static").
          with(:query => {:artist => "Radiohead", :type => :artist, :api_key => @api_key}).
          should have_been_made
      end

      it "returns a new playlist" do
        playlist = @client.playlist_create(:artist => "Radiohead", :type => :artist)

        playlist.should be_a_kind_of(Echorb::Playlist)
        playlist.songs.should have(15).songs
      end
    end
  end
end