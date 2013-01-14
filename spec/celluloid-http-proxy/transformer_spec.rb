require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::Transformer do
  it 'can be initialized from request' do
    reel_request = FakeRequest.to_localhost
    handlers = Factories.localhost_handlers
    transformer = Celluloid::Http::Proxy::Transformer.new reel_request, handlers
    transformer.should be_kind_of Celluloid::Http::Proxy::Transformer
  end

  it 'can transform response with custom transformer' do
    reel_request = FakeRequest.to_localhost
    handlers = Celluloid::Http::Proxy::HandlersProvider.register do
      condition :localhost do |r|
        r.host == "localhost"
      end

      on :localhost do 
        transform_response do |response|
           response.body = "transformed"
        end
      end
    end

    transformer = Celluloid::Http::Proxy::Transformer.new reel_request, handlers

    response = transformer.transform_response_for_client(FakeResponse.default)
    response.body.should eq "transformed"
  end

  it 'can transform request with custom transformer' do
    reel_request = FakeRequest.to_localhost
    handlers = Celluloid::Http::Proxy::HandlersProvider.register do
      condition :localhost do |r|
        r.host == "localhost"
      end

      on :localhost do 
        transform_request do |request|
           request.host = "external"
        end
      end
    end

    transformer = Celluloid::Http::Proxy::Transformer.new reel_request, handlers

    request = transformer.transform_request_for_backend

    request.host.should eq "external"
  end
end