require "echorb"
require "webmock/rspec"

def a_get(path, endpoint='http://developer.echonest.com/api/v4')
  a_request(:get, endpoint + path)
end

def a_post(path, endpoint='http://developer.echonest.com/api/v4')
  a_request(:post, endpoint + path)
end

def stub_get(path, endpoint='http://developer.echonest.com/api/v4')
  stub_request(:get, endpoint + path)
end

def stub_post(path, endpoint='http://developer.echonest.com/api/v4')
  stub_request(:post, endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(File.join(fixture_path, file))
end
