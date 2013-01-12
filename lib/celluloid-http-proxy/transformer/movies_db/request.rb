class MovieSourcesProxy::Transformer::MoviesDb::Request < MovieSourcesProxy::Transformer::Request
  include SimpleRouter::DSL

  get "/proxy/movies.json" do |request|
    request.path = request.path.sub(/\/proxy/, '/api')
    request.host = "movies-db.st1.ul.home"
    request.port = 80

    request
  end
end
