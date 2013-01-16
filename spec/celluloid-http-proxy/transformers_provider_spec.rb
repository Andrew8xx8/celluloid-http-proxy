require 'spec_helper'
require 'resolv'

describe Celluloid::Http::Proxy::TransformersProvider do
  it 'can register transformer on some condition' do
    transformers = Celluloid::Http::Proxy::TransformersProvider.register do
      transform_by FakeTransformer, :on do |r|
        r.host == 'localhost'
      end
    end

    request = Factories.request_to_localhost("movies.json?movie_source_id=1")

    transformers.for_request(request).first.should be_kind_of FakeTransformer
  end
end
