require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::Request do
  it 'can be initialized from reel request' do
    reel_request = FakeRequest.to_localhost

    request = Celluloid::Http::Proxy::Request.build_from_request reel_request

    request.scheme.should eq "http"
    request.host.should   eq "localhost"
    request.path.should   eq "/proxy/movies.json"
    request.query.should  eq "movie_source_id=1"
    request.port.should   eq 8080
    request.query_params.should eq({ "movie_source_id" => "1"})
    request.method.should eq :get
    request.body.should   eq ""
  end

  it 'can be initialized from url' do
    request = Factories.request_to_localhost("proxy/movies.json?movie_source_id=1")

    request.scheme.should eq"http"
    request.path.should eq"/proxy/movies.json"
    request.host.should eq "localhost"
    request.query.should eq "movie_source_id=1"
    request.port.should eq 8080
    request.query_params.should eq({ "movie_source_id" => "1"})
    request.method.should eq :get
    request.body.should eq nil
  end

#  def test_remove_param
#    request = MovieSourcesProxy::Proxy::Request.new( "http://localhost:8080//movies.json?movie_source_id=1&test=2" )
#
#    request.remove_param("movie_source_id")
#
#    assert_equal "test=2", request.query
#  end

  it 'can build url' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1&test=2")
    request.url.should eq "http://localhost:8080/movies.json?movie_source_id=1&test=2"
  end
end
