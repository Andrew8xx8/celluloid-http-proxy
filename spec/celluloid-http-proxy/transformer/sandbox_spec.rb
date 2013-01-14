require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::Transformer::Sandbox do
  it 'can transform requests' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1")

    handler = Proc.new do 
      transform_request do |r|
        r.host = "external"
      end 
    end

    request = Celluloid::Http::Proxy::Transformer::Sandbox.transform_request request, handler
    request.host.should eq "external"
  end 

  it 'can transform responses' do
    response = FakeResponse.default

    handler = Proc.new do 
      transform_response do |r|
        r.body = "Transformed body"
      end 
    end

    response = Celluloid::Http::Proxy::Transformer::Sandbox.transform_response response, handler
    response.body.should eq "Transformed body"
  end 

end
