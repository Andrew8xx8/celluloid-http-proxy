require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::Response do
  it 'can be initialized from reel response' do
    response = FakeResponse.new({
      status: 200,
      body: "body"
    })

    response = Celluloid::Http::Proxy::Response.build_from_response response

    response.status.should eq 200
    response.body.should   eq "body"
  end
end
