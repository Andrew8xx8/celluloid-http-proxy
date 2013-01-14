require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::HandlersProvider do
  it 'can register custom condition' do
    handlers_provider = Celluloid::Http::Proxy::HandlersProvider.register do
      condition :custom_condition do 
        true
      end
    end

    handlers_provider.apply_condition(:custom_condition, {}).should be true
  end

  it 'can register custom condition with param' do
    handlers_provider = Celluloid::Http::Proxy::HandlersProvider.register do
      condition :custom_condition do |request|
        request.host == "localhost"
      end
    end

    request = Celluloid::Http::Proxy::Request.new( "http://localhost:8080/proxy/movies.json?movie_source_id=1" )

    handlers_provider.apply_condition(:custom_condition, request).should be true
  end
end
