class Celluloid::Http::Proxy::Connection
  def initialize(transformers_provider)
    @transformers_provider = transformers_provider 
  end

  def accept(connection)
    while request = connection.request
      response = proxy_request request

      connection.respond response.sym_status, response.body
    end

    connection.close
  end

  def proxy_request(request)
    request = Celluloid::Http::Proxy::Request.build_from_request request
    proxy_request = transform_request request, request

    backend_response = get_response_from_backend(proxy_request)

    backend_response = Celluloid::Http::Proxy::Response.build_from_response backend_response
    transform_response request, backend_response
  end

  def get_response_from_backend(proxy_request)
    Celluloid::Http.send_request proxy_request
  end

  def transform_request(original_request, request)
    request = request.dup
    transformers = @transformers_provider.for_request original_request
    transformers.each do |transformer|
      request = transformer.transform_request request
    end

    request
  end

  def transform_response(original_request, response)
    transformers = @transformers_provider.for_request original_request
    transformers.each do |transformer|
      response = transformer.transform_response response
    end

    response
  end
end
