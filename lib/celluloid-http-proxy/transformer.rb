class Celluloid::Http::Proxy::Transformer
  autoload :Sandbox, 'celluloid-http-proxy/transformer/sandbox'

  def initialize(request, handlers_provider)
    @request = Celluloid::Http::Proxy::Request.build_from_request request

    if handlers_provider
      @handlers = handlers_provider.get_handlers_for_request(@request)
    else
      @handlers = []
    end
  end

  def transform_response_for_client(response)
    transform_response Celluloid::Http::Proxy::Response.build_from_response response
  end

  def transform_request_for_backend
    transform_request @request
  end

  def transform_response(response)
    response
  end

  def transform_request(request)
    request
  end

  def request_transformer
    @request_transformer ||= case @movie_source.handler
      when 'movies_db' then MovieSourcesProxy::Transformer::MoviesDb::Request.new
    end
  end

  def response_transformer
    @response_transformer ||= case @movie_source.handler
      when 'movies_db' then MovieSourcesProxy::Transformer::MoviesDb::Response.new
    end
  end
end
