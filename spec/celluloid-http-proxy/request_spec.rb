require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::Request do
  it 'can be initialized from reel request' do
    reel_request = FakeRequest.new({
      headers: { "Host" => "localhost:8080" },
      url: "/proxy/movies.json?movie_source_id=1",
      body: "",
      method: :get
    })

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

#  def test_initialize_from_url
#    request = MovieSourcesProxy::Proxy::Request.new( "http://localhost:8080/proxy/movies.json?movie_source_id=1" )
#
#    assert_equal "http", request.scheme
#    assert_equal "localhost", request.host
#    assert_equal "/proxy/movies.json", request.path
#    assert_equal "movie_source_id=1", request.query
#    assert_equal 8080, request.port
#    assert_equal({ "movie_source_id" => "1"}, request.query_params)
#    assert_equal :get, request.method
#    assert_equal nil, request.body
#  end
#
#  def test_remove_param
#    request = MovieSourcesProxy::Proxy::Request.new( "http://localhost:8080//movies.json?movie_source_id=1&test=2" )
#
#    request.remove_param("movie_source_id")
#
#    assert_equal "test=2", request.query
#  end
#
#  def test_build_url
#    request = MovieSourcesProxy::Proxy::Request.new( "http://localhost:8080//movies.json?movie_source_id=1&test=2")
#
#    assert_equal "http://localhost:8080//movies.json?movie_source_id=1&test=2", request.url
#  end
end 
