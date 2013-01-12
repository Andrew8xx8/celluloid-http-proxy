class Celluloid::Http::Proxy::Transformer
  autoload :Request, 'celluloid-http-proxy/proxy/request'
  autoload :Response, 'celluloid-http-proxy/proxy/response'

  def initialize(request)
    @request = Request.build_from_request request
    extract_movie_source
  end

  def transform_response_for_client(response)
    transform_response Response.build_from_response response
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
