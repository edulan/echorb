$:.unshift(File.dirname(__FILE__))
require 'spec_helper'

describe "Echorb" do
  it "should have a version" do
    Echorb::VERSION.should_not be_nil
  end
end
