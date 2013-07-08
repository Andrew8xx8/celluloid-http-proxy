class FakeRequest
  attr_accessor :headers, :path, :method, :body

  def initialize(params)
    @headers = params[:headers]
    @path = params[:path]
    @method = params[:method]
    @body = params[:body]
  end

  def self.to_localhost
    new({
      headers: { "Host" => "localhost:8080" },
      path: "/proxy/movies.json?movie_source_id=1",
      body: "",
      method: :get
    })
  end
end
