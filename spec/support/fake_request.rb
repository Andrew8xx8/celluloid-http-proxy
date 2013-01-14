class FakeRequest
  attr_accessor :headers, :url, :method, :body

  def initialize(params)
    @headers = params[:headers]
    @url = params[:url]
    @method = params[:method]
    @body = params[:body]
  end

  def self.to_localhost
    new({
      headers: { "Host" => "localhost:8080" },
      url: "/proxy/movies.json?movie_source_id=1",
      body: "",
      method: :get
    })
  end
end
