$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

module Echorb
  describe Artist do
    describe "#id" do
      it "should have an id" do
        artist = Artist.new

        artist.id.should_not be_nil
      end
    end
  end
end
