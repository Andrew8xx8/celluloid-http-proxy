class Celluloid::Http::Proxy::Connection

  def accept(connection)
    while request = connection.request
      response = proxy_request request

      connection.respond response.sym_status, response.body
    end

    connection.close
  end

  def proxy_request(request)
    transformer = Celluloid::Http::Proxy::Transformer.new(request)
    proxy_request = transformer.transform_request_for_backend

    backend_response = get_response_from_backend(proxy_request)
    transformer.transform_response_for_client(backend_response)
  end

  def get_response_from_backend(proxy_request)
    Celluloid::Http.send_request proxy_request
  end

end
