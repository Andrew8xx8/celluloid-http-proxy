require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::HandlersProvider do
  it 'can raise exception on trying to get missing condition' do
    handlers_provider = Celluloid::Http::Proxy::HandlersProvider.register do
    end

    expect { handlers_provider.get_condition(:missing_condition) }.to raise_error
  end

  it 'can register custom condition' do
    handlers_provider = Celluloid::Http::Proxy::HandlersProvider.register do
      condition :custom_condition do 
        true
      end
    end

    handlers_provider.get_condition(:custom_condition).should be_a_kind_of Proc
    handlers_provider.get_condition(:custom_condition).call.should eq true
  end

  it 'can register handler on custom condition' do
    request = Factories.request_to_localhost("movies.json?movie_source_id=1")
    handlers_provider = Factories.localhost_handlers

    handlers = handlers_provider.get_handlers(:custom_condition, request)
    handlers.count.should eq 1 
    handlers.first[:condition].should eq :custom_condition
    handlers.first[:block].should be_a_kind_of Proc
    handlers.first[:block].call.should eq true
  end
end
