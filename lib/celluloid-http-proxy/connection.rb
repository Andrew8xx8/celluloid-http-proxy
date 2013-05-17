class Celluloid::Http::Proxy::Connection
  def initialize(transformers_provider)
    @transformers_provider = transformers_provider 
  end

  def accept(connection)
    while request = connection.request
      response = proxy_request request

      connection.respond response.sym_status, response.body
    end

    connection.close unless connection.socket.closed?
  end

  def proxy_request(request)
    request = Celluloid::Http::Proxy::Request.build_from_request request
    transformers = @transformers_provider.for_request request
    proxy_request = transform_request transformers, request

    backend_response = get_response_from_backend(proxy_request)

    backend_response = Celluloid::Http::Proxy::Response.build_from_response backend_response
    transform_response transformers, backend_response
  end

  def get_response_from_backend(proxy_request)
    Celluloid::Http.send_request proxy_request
  end

  def transform_request(transformers, request)
    transformers.each do |transformer|
      request = transformer.transform_request request
    end

    request
  end

  def transform_response(transformers, response)
    transformers.each do |transformer|
      response = transformer.transform_response response
    end

    response
  end
end
