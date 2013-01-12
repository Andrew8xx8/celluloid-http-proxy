class MovieSourcesProxy::Transformer::Request

  def call(request)
    route = self.class.routes.match(request.method, request.path)
    route.nil? ? raise(MovieSourcesProxy::Transformer::Router::RouteNotFound.new "RouteNotFound: #{request.url}") : route.action.call(request)
  end
end
