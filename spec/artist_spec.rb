require "spec_helper"
require "json"

module Echorb
  describe Artist do
    before do
      @attrs = {:id => 1, :name => "Radiohead", :familiarity => 0.75}
      @artist = Artist.new(@attrs)
    end

    describe "#id" do
      it "returns the artist id" do
        @artist.id.should == 1
      end
    end

    describe "#name" do
      it "returns the artist name" do
        @artist.name.should == "Radiohead"
      end
    end

    describe "#familiarity" do
      it "returns the artist familiarity" do
        @artist.familiarity.should == 0.75
      end
    end

    describe "#to_json" do
      it "returns a json representation of the artist" do
        json_attrs = @attrs.to_json

        @artist.to_json.should == json_attrs
      end
    end
  end
end
