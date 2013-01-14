class Celluloid::Http::Proxy::Transformer
  def initialize(request)
    @request = Celluloid::Http::Proxy::Request.build_from_request request
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
