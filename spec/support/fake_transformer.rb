class FakeTransformer < Celluloid::Http::Proxy::Transformer
  def transform_response(response)
  end

  def transform_request(request)
  end
end
